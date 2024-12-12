extends Node2D

var endLevel = false
@onready var player = $Player
@onready var finishQuest = $QuestFinish
@onready var startWaves = $NPCs/NPC
@export var coin: PackedScene   # Drag and drop your enemy scene here in the Inspector
@onready var spawner1 = $Node/Spawner
@onready var spawner2 = $Node/Spawner2
@onready var spawner3 = $Node/Spawner3
@onready var spawner4 = $Node/Spawner4

var buildings = [ 
	preload("res://Scenes/NPC's/Tower/TowerBase.tscn"),
	preload("res://Scenes/NPC's/Healing/HealingTower.tscn") ,
	preload("res://Scenes/NPC's/SpeedBoost/SpeedBoostTower.tscn") ,
	preload("res://Scenes/NPC's/DamageBoost/DamageBoostTower.tscn") ,
]

var killCount = 0

var current_building = null
var reject: Node = null
var accept: Node = null
var ending = false
var negativeShown = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("interacted_with", Callable(self, "_on_interacted_with"))
	GameManager.connect("died", Callable(self, "_on_killed"))
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	GameManager.add_money(100)
	pass # Replace with function body.

func _input(event): 
	if event is InputEventKey: 
		if event.pressed: 
			#print(event)
			match event.keycode: 
				49: 
					set_current_building(0) 
				50: 
					set_current_building(1) 
				51: 
					set_current_building(2) 
				52: 
					set_current_building(3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !negativeShown && killCount > 20:
		negativeShown = true
		GameManager.show_popup("res://Scenes/Levels/Negative/Negative.tscn", player, Vector2(-320, -180))

	if !ending && killCount > 55:
		ending = true
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Levels/Creative/CreativeInfo.tscn")

	if current_building: 
		current_building.position = get_global_mouse_position() 
	if 	Input.is_action_just_pressed("Punch") and current_building: 
		if (GameManager.money >= 10):
			GameManager.add_money(-10)
			place_building() 
		else:
			var label = Label.new()
			label.text = "I don't have enough coins"  # Set the text
			#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.position = Vector2(-80, -50)  # Position it above the player (adjust as needed)
			# Add the Label as a child of the player
			current_building.queue_free()
			current_building = null
			GameManager.playerAttacks = true
			player.add_child(label)
			await get_tree().create_timer(1.5).timeout
			player.remove_child(label)
	if Input.is_action_just_pressed("Kick") and current_building: 
		current_building.queue_free()
		current_building = null
		GameManager.playerAttacks = true

func place_building(): 
	GameManager.playerAttacks = true
	current_building = null

func set_current_building(index): 
	#print(index)
	GameManager.playerAttacks = false
	if current_building: 
		current_building.queue_free()
	current_building = buildings[index].instantiate() 
	add_child(current_building) 
	current_building.position = get_global_mouse_position() 

func _on_killed(display_name, position):
	print(display_name, position)
	match display_name:
		"Enemy":
			spawn_coins(position, int(randf_range(1, 2)))
			killCount += 1
			print(killCount)
		"Tree":
			spawn_coins(position, int(randf_range(1, 2)))
	pass
	
func spawn_coins(position, amount):
	if not coin:
		print("Coin scene not set!")
		return

	for i in range(amount):
		var coin_instance = coin.instantiate()
		# Randomize the coin position slightly around the original position
		var random_offset = Vector2(
			randf_range(-2, 2), # Adjust range as needed
			randf_range(-2, 2)  # Adjust range as needed
		)
		coin_instance.position = position + random_offset
		add_child(coin_instance)

	# Add the enemy to the scene
	#spawnParent.add_child(enemy_instance)


func _on_touch_zone_interacted(display_name) -> void:
	match display_name:
		"Start the Onslaight":
			var label = Label.new()
			label.text = "Confirm that you want to start the waves of enemies"  # Set the text
			#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.position = Vector2(-200, -80)  # Position it above the player (adjust as needed)
			# Add the Label as a child of the player
			startWaves.add_child(label)
			await get_tree().create_timer(3.5).timeout
			startWaves.remove_child(label)
			
			reject = Button.new()
			reject.text = "Not Ready"  # Set the text
			#reject.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			reject.alignment = HORIZONTAL_ALIGNMENT_CENTER
			reject.position = Vector2(-75, -50) 
			#reject.modulate = GameManager.textColor
			
			accept = Button.new()
			accept.text = "Confirm"  # Set the text
			#accept.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			accept.alignment = HORIZONTAL_ALIGNMENT_CENTER
			accept.position = Vector2(25, -50) 
			#accept.modulate = GameManager.textColor
			
			player.add_child(reject)
			player.add_child(accept)
			reject.connect("pressed", Callable(self, "_on_reject_pressed"))
			accept.connect("pressed", Callable(self, "_on_accept_pressed"))

func _on_reject_pressed() -> void:
	# Remove the buttons (clean up)
	player.remove_child(reject)
	player.remove_child(accept)

# Function to handle when "accept" is pressed
func _on_accept_pressed() -> void:
	# Remove the buttons (clean up)
	player.remove_child(reject)
	player.remove_child(accept)
	start_waves()
	
func start_waves():
	spawner1.max_spawns = 15
	spawner1.position = Vector2(-607, -42)
	spawner2.max_spawns = 15
	spawner2.position = Vector2(6, -491)
	spawner3.max_spawns = 15
	spawner3.position = Vector2(515, -32)
	spawner4.max_spawns = 15
	spawner4.position = Vector2(6, 474)
	pass
	
	

	
