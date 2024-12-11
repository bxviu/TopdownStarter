extends Node2D

@export var zone_name = "Zone"
var emitted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
		if body.is_in_group("Player") and !emitted:
			print("object ", zone_name, " touched.")
			emitted = true
			GameManager.emit_signal("interacted_with", zone_name)

func _on_body_exited(body):
	if body.is_in_group("Player") and emitted:
		await get_tree().create_timer(1).timeout #Show the text for a short while after the player leaves
		emitted = false
