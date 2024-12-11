extends Node2D

var interacted = []
var doorOpened = false
@onready var exit = $Scene/AreaExit
@onready var player = $Player
@onready var damageTowers = $DamageTowers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	for child in damageTowers.get_children():
		child.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interacted.size() == 3 and !doorOpened:
		doorOpened = true
		exit.position.y = -47
	pass
	
func _on_touch_zone_interacted(display_name) -> void:
	var label = Label.new()
	if display_name not in interacted:
		label.text = "Damage Towers Summoned"  # Set the text
		interacted.append(display_name)
		for child in damageTowers.get_children():
			child.show()
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
	if display_name not in interacted:
		interacted.append(display_name)
	pass # Replace with function body.

func _on_touch_zone_3_interacted(display_name: Variant) -> void:
	if display_name not in interacted:
		interacted.append(display_name)
	pass # Replace with function body.

func _on_touch_zone_4_interacted(display_name: Variant) -> void:
	if display_name not in interacted:
		interacted.append(display_name)
	pass # Replace with function body.
