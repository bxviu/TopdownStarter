extends Node2D

var interacted = []
var doorOpened = false
@onready var exit = $Scene/AreaExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interacted.size() == 3 and !doorOpened:
		doorOpened = true
		exit.position.y = -47
	pass
	
func _on_touch_zone_interacted(display_name) -> void:
	if display_name not in interacted:
		interacted.append(display_name)

func _on_touch_zone_2_interacted(display_name: Variant) -> void:
	if display_name not in interacted:
		interacted.append(display_name)
	pass # Replace with function body.


func _on_touch_zone_3_interacted(display_name: Variant) -> void:
	if display_name not in interacted:
		interacted.append(display_name)
	pass # Replace with function body.
