extends Node2D

var focusShown = false
var identityShown = false
var creativeShown = false
var negativeShown = false
var endingLevel = false
@onready var player = $Player
@onready var appleMan = $NPCs/NPC
@onready var hungryMan = $NPCs/NPC3
@onready var specialApple = $NPCs/NPC3/TouchZone2
@export var coin: PackedScene   # Drag and drop your enemy scene here in the Inspector
var appleManTalked = false
var hungryManTalked = false
var gotSpecialApple = false
var hungryNoMore = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("interacted_with", Callable(self, "_on_interacted_with"))
	GameManager.connect("died", Callable(self, "_on_killed"))
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	specialApple.interactable = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_killed(display_name, position):
	print(display_name, position)
	match display_name:
		"Enemy":
			spawn_coin(position)
	pass
	
func spawn_coin(position):
	if not coin:
		print("Enemy scene not set!")
		return
	var coin_instance = coin.instantiate()
	var coin_instance2 = coin.instantiate()
	var coin_instance3 = coin.instantiate()
	var coin_instance4 = coin.instantiate()
	coin_instance.position = position
	coin_instance2.position = Vector2(position.x+2, position.y)
	coin_instance3.position = Vector2(position.x+2, position.y-2)
	coin_instance4.position = Vector2(position.x+1, position.y-1)
	add_child(coin_instance)
	add_child(coin_instance2)
	add_child(coin_instance3)
	add_child(coin_instance4)
	# Add the enemy to the scene
	#spawnParent.add_child(enemy_instance)


func _on_touch_zone_interacted(display_name) -> void:
	match display_name:
		"Artist":
			if (identityShown):
				GameManager.show_popup("res://Scenes/Levels/Identity/PlayerColorChanger.tscn", player, Vector2(-320, -180))
			else:
				identityShown = true;
				GameManager.show_popup("res://Scenes/Levels/Identity/Identity.tscn", player, Vector2(-320, -180))
		"Apple Man":
			if !appleManTalked:
				appleManTalked = true
				appleManDialogue()
		"Hungry Man":
			if !hungryManTalked:
				hungryManTalked = true
				hungryManDialogue()
			elif !hungryNoMore and hungryManTalked and gotSpecialApple:
				hungryNoMore = true
				hungryManDialogue3()
		"Special Apple":
			if !gotSpecialApple:
				gotSpecialApple = true
				hungryManDialogue2()
			
func appleManDialogue():
	var label = Label.new()
	label.text = "Here have 50 coins, spread the word of apples"  # Set the text
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = Vector2(-120, -80)  # Position it above the player (adjust as needed)
	GameManager.add_money(50)
	# Add the Label as a child of the player
	appleMan.add_child(label)
	await get_tree().create_timer(1.5).timeout
	appleMan.remove_child(label)

func hungryManDialogue():
	var label = Label.new()
	label.text = "Ill give you 50 coins if you get me my apple, its on the opposite side of the map, just go straight up"  # Set the text
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = Vector2(-240, -80)  # Position it above the player (adjust as needed)
	specialApple.interactable = true
	# Add the Label as a child of the player
	hungryMan.add_child(label)
	await get_tree().create_timer(1.5).timeout
	hungryMan.remove_child(label)
	
func hungryManDialogue2():
	var label = Label.new()
	label.text = "I should bring this apple back to the hungry man"  # Set the text
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = Vector2(-120, -50)  # Position it above the player (adjust as needed)
	# Add the Label as a child of the player
	player.add_child(label)
	await get_tree().create_timer(1.5).timeout
	player.remove_child(label)
	specialApple.interactable = false
	
func hungryManDialogue3():
	var label = Label.new()
	label.text = "Thank you, I shall no longer be hungry!!!"  # Set the text
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = Vector2(-120, -80)  # Position it above the player (adjust as needed)
	GameManager.add_money(50)
	# Add the Label as a child of the player
	hungryMan.add_child(label)
	await get_tree().create_timer(1.5).timeout
	hungryMan.remove_child(label)
