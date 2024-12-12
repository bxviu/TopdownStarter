extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Negative agency occurs when players expect a certain type of agency, but the game denies it. This can happen due to implicit promises or other expectations. Unlike static works where audience agency isn't expected, negative agency feels like something has been taken away.",
	"When used judiciously, negative agency can be a powerful tool to convey themes of frustration, powerlessness, and oppression. However, it can easily be perceived as lazy or malicious if not implemented well. Games denying expected agency should offer unexpected forms of agency to balance this.",
	"There were some moments of negative agency in this game. Such as this popping up right now while you are fighting enemies. It's negative because most likely you weren't expecting to have some text pop up. There were some other parts where the text pops up abruptly, and I apologize but I am running out of time so I can't fix it.",
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
