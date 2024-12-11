extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Weak interaction offers the sensation of agency without the substance, involving players in minor, inconsequential actions. Think of pressing a button to light up a display in a museum or advancing text in a kinetic novel. The idea is simple: requiring players to 'bump against' the content can heighten attention and investment.",
	"However, weak interaction isn’t universally effective. If players sense that the actions they’re taking have no meaningful impact or won’t require deeper engagement, they may disengage, skimming or skipping through content. This is especially true when weak interactivity is used in contexts that promise more meaningful agency, as seen in later Choose Your Own Adventure books that became increasingly linear and unsatisfying.",
	"When used carefully, though, weak interaction can serve a purpose. It’s excellent for pacing, breaking up heavy moments or choices without overwhelming the player. Splitting text into smaller, interactive chunks also makes the experience feel more dynamic. Creators must balance this carefully, ensuring the audience’s expectations align with the level of interactivity provided.",
	"An example of weak interation is the fact that the player must left click to continue reading, like right now.",
	"Another example, in this game, is that the NPCs continue to exist or move around without the player's input."
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
signal popup_closed

func _on_close_button_pressed():
	# Emit the signal to notify the main scene
	emit_signal("popup_closed")
	
	# Queue free the pop-up scene
	queue_free()
	
func _ready():
	continue_label.text = "Click to continue: 1/" + str(len(narrative_texts))
	title.modulate = GameManager.textColor
	narrative_label.modulate = GameManager.textColor
	continue_label.modulate = GameManager.textColor
	# Show first text block
	show_next_text()
	
	# Enable input processing
	set_process_input(true)
	#$OmnipotenceButton.connect("pressed", Callable(self, "_on_omnipotence_button_pressed"))
	#$NormalButton.connect("pressed", Callable(self, "_on_normal_button_pressed"))

## Function called when the Start button is pressed
#func _on_omnipotence_button_pressed():
	#GameManager.linear = false
	## Replace "res://main_game_scene.tscn" with the path to your main game scene
	#get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
#
## Function called when the Quit button is pressed
#func _on_normal_button_pressed():
	#GameManager.current_level = -2
	#GameManager.selected_level = -1
	#get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	
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
	_on_close_button_pressed()
	# What to do when narrative ends
	# For example, change to next scene
	#get_tree().change_scene_to_file("res://next_scene.tscn")
