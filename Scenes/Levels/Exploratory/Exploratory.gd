extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var player = $Player
var interacted = []

@onready var popup_scene = preload("res://Scenes/Levels/Weak Interactive/WeakInteractive.tscn")
var weakInteractiveShown = false
var aestheticsShown = false

#func show_popup():
	## Instance and add the popup scene
	#var popup = popup_scene.instantiate()
	#player.add_child(popup)
	#popup.position = Vector2(-320, -180)
	#popup.z_index = 2
	#
	## Pause the main scene
	#get_tree().paused = true
	#
	## Connect to a custom signal from the popup to unpause and clean up
	#popup.connect("popup_closed", Callable(self, "_on_popup_closed"))

#func _on_popup_closed():
	## Unpause the main scene
	#get_tree().paused = false

func play_looping_animation():
	animation_player.get_animation("move_area").loop = true
	animation_player.play("move_area")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_looping_animation()
	GameManager.connect("interacted_with", Callable(self, "_on_interacted_with"))
	GameManager.playerDash = true
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_interacted_with(object: String):
	if object not in interacted:
		interacted.append(object)
	if !weakInteractiveShown and interacted.size() == 4:
		print('done')
		weakInteractiveShown = true
		GameManager.show_popup("res://Scenes/Levels/Weak Interactive/WeakInteractive.tscn", player, Vector2(-320, -180))
	
func _on_touch_zone_interacted() -> void:
	if (aestheticsShown):
		GameManager.show_popup("res://Scenes/Levels/Aesthetic/TextColorChanger.tscn", player, Vector2(-320, -180))
	else:
		aestheticsShown = true;
		GameManager.show_popup("res://Scenes/Levels/Aesthetic/Aesthetic.tscn", player, Vector2(-320, -180))
		#await get_tree().create_timer(1).timeout
		#print("showing")
		#GameManager.show_popup("res://Scenes/Levels/Aesthetic/TextColorChanger.tscn", player, Vector2(-320, -180))
