extends Control

# Array of narrative text blocks
var narrative_texts = [
	"For some players, protagonism in games doesn't work unless it's paired with self-insertion. They want to imagine the player character as themselves or a fantasy version of themselves. This allows them to express their personality through play style and avoid content that doesn't align with their identity. When this alignment is disrupted, it can feel like a loss of agency.",
	"Players have different preferences for self-insertion and character identity. Some players want characters who match their own identities, while others enjoy playing characters with different traits. This variation is seen in both video games and tabletop RPGs, where players' comfort levels with certain types of characters can vary greatly.",
	"Identity choices in games can influence how players engage with the story and gameplay. While some players appreciate the ability to play any character they want, this can sometimes make the character feel irrelevant. In contrast, some games focus heavily on identity choices, making the story about the character's origin and development.",
	"Games that cater to specific identities, such as privileged straight white male gamers, can alienate other players. Ensuring diverse representation in games can enhance the sense of agency for all players. Games that avoid ignoring or marginalizing certain groups tend to offer a richer and more inclusive experience.",
	"In this game, the agency of identity is shown through customizing the color of the player. Press E again after this closes to change the color of the player."
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
signal popup_closed
#
#func _on_close_button_pressed():
	## Emit the signal to notify the main scene
	#emit_signal("popup_closed")
	#
	## Queue free the pop-up scene
	#queue_free()
	
func _ready():
	continue_label.text = "Click to continue: 1/" + str(len(narrative_texts))
	title.modulate = GameManager.textColor
	narrative_label.modulate = GameManager.textColor
	continue_label.modulate = GameManager.textColor
	# Show first text block
	show_next_text()
	
	# Enable input processing
	set_process_input(true)

func _input(event):
	# Check for left mouse button click
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			show_next_text()

func show_next_text():
	continue_label.text = "Click to continue: " + str(current_text_index+1) + "/" + str(len(narrative_texts))
	# Check if there are more text blocks
	if current_text_index < narrative_texts.size():
		# Update label with current text
		narrative_label.text = narrative_texts[current_text_index]
		current_text_index += 1
		
		# Update continue label visibility
		update_continue_label()
	else:
		# Narrative is complete
		on_narrative_complete()

func update_continue_label():
	# Show/hide continue hint based on remaining text
	continue_label.visible = current_text_index <= narrative_texts.size()

func on_narrative_complete():
	continue_label.hide()
	emit_signal("popup_closed")
	
	#_on_close_button_pressed()
	# What to do when narrative ends
	# For example, change to next scene
	#get_tree().change_scene_to_file("res://Scenes/Levels/Aesthetic/TextColorChanger.tscn")
