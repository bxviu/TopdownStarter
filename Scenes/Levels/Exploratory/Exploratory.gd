extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var player = $Player
var interacted = []

@onready var popup_scene = preload("res://Scenes/Levels/Weak Interactive/WeakInteractive.tscn")

func show_popup():
	# Instance and add the popup scene
	var popup = popup_scene.instantiate()
	player.add_child(popup)
	
	# Pause the main scene
	get_tree().paused = true
	
	# Connect to a custom signal from the popup to unpause and clean up
	popup.connect("popup_closed", Callable(self, "_on_popup_closed"))

func _on_popup_closed():
	# Unpause the main scene
	get_tree().paused = false

func setup_animation():
	if not animation_player.has_animation("move_area"):
		animation_player.add_animation("move_area")
		
	## Add animation track
	#var track_idx = animation_player.add_track(Animation.TYPE_VALUE)
	#animation_player.track_set_path(track_idx, "../Area2D:position")
	#
	## Add animation keys
	#animation_player.track_insert_key(track_idx, 0, Vector2(0, 0))
	#animation_player.track_insert_key(track_idx, 1, Vector2(200, 200))
	#animation_player.track_insert_key(track_idx, 2, Vector2(0, 0))
	
	# Set the animation to loop
	animation_player.set_animation_loop("move_area", true)

func play_looping_animation():
	animation_player.get_animation("move_area").loop = true
	animation_player.play("move_area")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_looping_animation()
	GameManager.connect("interacted_with", Callable(self, "_on_interacted_with"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_interacted_with(object: String):
	if object not in interacted:
		interacted.append(object)
	if interacted.size() >= 2:
		print('done')
		show_popup()
	
