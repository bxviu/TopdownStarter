extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var player = $Player
@onready var bob = $NPCs/Beggar
var interacted = []

@onready var popup_scene = preload("res://Scenes/Levels/Weak Interactive/WeakInteractive.tscn")
var weakInteractiveShown = false
var aestheticsShown = false
var reflectiveShown = false
var endingLevel = false

var reject: Node = null
var accept: Node = null
var coinsGiven = false

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
	if !endingLevel and weakInteractiveShown and aestheticsShown and reflectiveShown:
		endingLevel = true
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/Levels/Intermission/Intermission.tscn")
	pass
	
func _on_interacted_with(object: String):
	if object not in interacted:
		interacted.append(object)
	if !weakInteractiveShown and interacted.size() == 4:
		print('done')
		weakInteractiveShown = true
		GameManager.show_popup("res://Scenes/Levels/Weak Interactive/WeakInteractive.tscn", player, Vector2(-320, -180))
	
func _on_touch_zone_interacted(display_name) -> void:
	match display_name:
		"Painter":
			if (aestheticsShown):
				GameManager.show_popup("res://Scenes/Levels/Aesthetic/TextColorChanger.tscn", player, Vector2(-320, -180))
			else:
				aestheticsShown = true;
				GameManager.show_popup("res://Scenes/Levels/Aesthetic/Aesthetic.tscn", player, Vector2(-320, -180))
		"Bob":
			var label = Label.new()
			label.text = "Do you have any spare coins...?"  # Set the text
			#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.position = Vector2(-60, -50)  # Position it above the player (adjust as needed)
			# Add the Label as a child of the player
			bob.add_child(label)
			await get_tree().create_timer(1.5).timeout
			bob.remove_child(label)
			
			reject = Button.new()
			reject.text = "Sorry, no"  # Set the text
			#reject.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			reject.alignment = HORIZONTAL_ALIGNMENT_CENTER
			reject.position = Vector2(-75, -50) 
			#reject.modulate = GameManager.textColor
			
			accept = Button.new()
			accept.text = "Sure"  # Set the text
			#accept.anchor_mode = Control.ANCHOR_BEGIN  # Center it
			accept.alignment = HORIZONTAL_ALIGNMENT_CENTER
			accept.position = Vector2(25, -50) 
			#accept.modulate = GameManager.textColor
			
			player.add_child(reject)
			player.add_child(accept)
			reject.connect("pressed", Callable(self, "_on_reject_pressed"))
			accept.connect("pressed", Callable(self, "_on_accept_pressed"))

func _on_reject_pressed() -> void:
	# Handle the rejection action
	print("Sorry, no!")
	# Remove the buttons (clean up)
	player.remove_child(reject)
	player.remove_child(accept)
	continue_dialogue()

# Function to handle when "accept" is pressed
func _on_accept_pressed() -> void:
	# Handle the acceptance action
	coinsGiven = true
	print("Sure!")
	# Remove the buttons (clean up)
	player.remove_child(reject)
	player.remove_child(accept)
	continue_dialogue()
	
func continue_dialogue():
	GameManager.add_money(-3)
	var label = Label.new()
	if coinsGiven:
		label.text = "Hope he uses those coins wisely."  # Set the text
		label.position = Vector2(-100, -50)  # Position it above the player (adjust as needed)
	else:
		label.text = "Did he just pickpocket me while I was looking at him??? Oh well"  # Set the text
		label.position = Vector2(-200, -50)  # Position it above the player (adjust as needed)
	label.modulate = GameManager.textColor
	#label.anchor_mode = Control.ANCHOR_BEGIN  # Center it
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	# Add the Label as a child of the player
	player.add_child(label)
	await get_tree().create_timer(3).timeout
	player.remove_child(label)
	bob.hide()
	await get_tree().create_timer(0.5).timeout
	GameManager.show_popup("res://Scenes/Levels/Reflective/Reflective.tscn", player, Vector2(-320, -180))
	reflectiveShown = true
	
