extends Node2D

var interacted = []
var doorOpened = false
@onready var exit = $Scene/AreaExit
@onready var player = $Player
@onready var quest = $Scene/Quests/QuestUpdate3
@onready var damageTowers = $DamageTowers
@onready var damageBoostTowers = $DamageBoostTowers
@onready var healingTowers = $HealingTowers
@onready var speedBoostTower = $SpeedBoostTower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	GameManager.connect("died", Callable(self, "on_spawner_killed"))
	speedBoostTower.hide()
	var collision_shape = speedBoostTower.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")
	collision_shape.disabled = true 
	for child in damageTowers.get_children():
		child.hide()
		child.position.x -= 500
	for child in healingTowers.get_children():
		child.hide()
		collision_shape = child.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")  # Adjust path if necessary
		if collision_shape:
			collision_shape.disabled = true 
	for child in damageBoostTowers.get_children():
		child.hide()
		collision_shape = child.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")  # Adjust path if necessary
		if collision_shape:
			collision_shape.disabled = true 
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_spawner_killed(display_name, position):
	match display_name:
		"Spawner":
			doorOpened = true
			exit.position.y = -624
			quest.position.x = 388
			print('next')
	pass
	
func _on_touch_zone_interacted(display_name) -> void:
	var label = Label.new()
	if display_name not in interacted:
		label.text = "Damage Towers Summoned"  # Set the text
		interacted.append(display_name)
		for child in damageTowers.get_children():
			child.show()
			child.position.x += 500
	else:
		label.text = "Already Activated"  # Set the text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.modulate = GameManager.textColor
	label.position = Vector2(-60, -50)  # Position it above the player (adjust as needed)
	player.add_child(label)
	await get_tree().create_timer(1.5).timeout
	player.remove_child(label)
	pass # Replace with function body.

func _on_touch_zone_2_interacted(display_name: Variant) -> void:
	var label = Label.new()
	if display_name not in interacted:
		label.text = "Speed Boost Tower Summoned"  # Set the text
		interacted.append(display_name)
		speedBoostTower.show()
		var collision_shape = speedBoostTower.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")  # Adjust path if necessary
		collision_shape.disabled = false 
	else:
		label.text = "Already Activated"  # Set the text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.modulate = GameManager.textColor
	label.position = Vector2(-60, -50)  # Position it above the player (adjust as needed)
	player.add_child(label)
	await get_tree().create_timer(1.5).timeout
	player.remove_child(label)

func _on_touch_zone_3_interacted(display_name: Variant) -> void:
	var label = Label.new()
	if display_name not in interacted:
		label.text = "Damage Boost Towers Summoned"  # Set the text
		interacted.append(display_name)
		for child in damageBoostTowers.get_children():
			child.show()
			var collision_shape = child.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")  # Adjust path if necessary
			collision_shape.disabled = false 
	else:
		label.text = "Already Activated"  # Set the text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.modulate = GameManager.textColor
	label.position = Vector2(-60, -50)  # Position it above the player (adjust as needed)
	player.add_child(label)
	await get_tree().create_timer(1.5).timeout
	player.remove_child(label)

func _on_touch_zone_4_interacted(display_name: Variant) -> void:
	var label = Label.new()
	if display_name not in interacted:
		label.text = "Healing Towers Summoned"  # Set the text
		interacted.append(display_name)
		for child in healingTowers.get_children():
			child.show()
			var collision_shape = child.get_node("AnimatedSprite2D/Hitboxes/area_hitbox/hitboxShape")  # Adjust path if necessary
			collision_shape.disabled = false 
	else:
		label.text = "Already Activated"  # Set the text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.modulate = GameManager.textColor
	label.position = Vector2(-60, -50)  # Position it above the player (adjust as needed)
	player.add_child(label)
	await get_tree().create_timer(1.5).timeout
	player.remove_child(label)
