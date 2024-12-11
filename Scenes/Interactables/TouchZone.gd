extends Node2D

@export var zone_name = "Zone"
@export var interactable = false
#@export var path = ""
#@export var parent: Node = null 

@onready var prompt = $EtoInteract
@onready var display = $Name

signal interacted(display_name)
var emitted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if interactable:
		display.text = zone_name
		display.show()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("Enter") and prompt.visible == true):
		emit_signal("interacted", zone_name)
		#GameManager.show_popup(path, parent)
	pass

func _on_body_entered(body):
		if body.is_in_group("Player") and !emitted:
			if interactable:
				prompt.show()
			print("object ", zone_name, " touched.")
			emitted = true
			GameManager.emit_signal("interacted_with", zone_name)

func _on_body_exited(body):
	if body.is_in_group("Player") and emitted:
		if interactable:
			prompt.hide()
			await get_tree().create_timer(0.1).timeout #Show the text for a short while after the player leaves
		else:
			await get_tree().create_timer(1).timeout #Show the text for a short while after the player leaves
		emitted = false
