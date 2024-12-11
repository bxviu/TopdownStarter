extends Control

# Array of narrative text blocks
var narrative_texts = [
	"In Ashwell's essay. 'A Bestiary of Player Agency,'  they explore 16 types of player agency.",
	"The agencies of Protagonism, Big Decisions, Exploratory, Weak interactive, Aesthetic, Reflective choices, Grasp, Velocity, Challenge, Tactics and strategy, Meta, Possibility, Focus, Identity, Creative, and Negative agency.",
 	"This interactive game will provide examples for all of them, starting with...",
]

# Current text index
var current_text_index = 0
var goToNext = false

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
@onready var big = $BigText

func _ready():
	continue_label.text = "Click to continue: 1/" + str(len(narrative_texts))
	big.hide()
	title.modulate = GameManager.textColor
	narrative_label.modulate = GameManager.textColor
	continue_label.modulate = GameManager.textColor	
	big.modulate = GameManager.textColor
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
	elif goToNext:
		on_narrative_complete()
	else:
		# Narrative is complete
		big.show()
		title.hide()
		narrative_label.hide()
		#on_narrative_complete()
		goToNext = true

func update_continue_label():
	# Show/hide continue hint based on remaining text
	continue_label.visible = current_text_index <= narrative_texts.size()

func on_narrative_complete():
	# What to do when narrative ends
	# For example, change to next scene
	get_tree().change_scene_to_file("res://Scenes/Levels/Protaganism/Protaganism.tscn")
