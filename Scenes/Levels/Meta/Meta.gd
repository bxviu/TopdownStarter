extends Node2D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("interacted_with", Callable(self, "_on_interacted_with"))
	GameManager.playerDash = true
	GameManager.playerAttacks = true
	await get_tree().create_timer(20).timeout
	continue_dialogue()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		#await get_tree().create_timer(2).timeout
		#get_tree().change_scene_to_file("res://Scenes/Levels/Intermission/Intermission.tscn")
	pass

	
func continue_dialogue():
	var label = Label.new()
	label.text = "Am I stuck here? All the exits have been sealed off by other survivors..."  # Set the text
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.modulate = GameManager.textColor
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.position = Vector2(-300, -50)  # Position it above the player (adjust as needed)
	# Add the Label as a child of the player
	player.add_child(label)
	await get_tree().create_timer(3.5).timeout
	player.remove_child(label)
	
	label = Label.new()
	label.text = "Modifying Game: Changing Location"
	label.position = Vector2(-150, -50)  # Position it above the player (adjust as needed)
	player.add_child(label)
	
	var accept = Button.new()
	accept.text = "Confirm" #et the text
	accept.alignment = HORIZONTAL_ALIGNMENT_CENTER
	accept.position = Vector2(-25, -75) 
	player.add_child(accept)

	accept.connect("pressed", Callable(self, "_on_accept_pressed"))
	
func _on_accept_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Meta/NewArea.tscn")
	
