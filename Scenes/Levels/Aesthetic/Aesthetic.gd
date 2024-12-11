extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Aesthetic agency involves personalizing the visual or identity aspects of a game, like choosing character appearances, colors, or decorations for a virtual space. It doesn’t affect the gameplay mechanics or story but offers players a chance to express themselves through choices like hairstyles or T-shirt colors. Players don’t expect these choices to change the game or influence the world significantly.",
	"However, aesthetic choices can still be meaningful. They foster a sense of co-authorship, allowing players to invest in the game world on a personal level, even if the impact is purely visual. Often, the aesthetic options reflect the game’s boundaries, revealing the types of characters or environments players can interact with, thus shaping their connection to the game. In this way, aesthetics create a sense of ownership, even if that ownership is mostly illusory.",
	"In this game, it provides you with an aesthetic choice when you change the color of the text that displays when talking about agency."
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
