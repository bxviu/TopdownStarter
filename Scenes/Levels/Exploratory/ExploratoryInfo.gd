extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Exploratory agency is the freedom to roam and discover. It relies on a player’s ability to move through a space, take their time, and encounter things worth observing. This type of agency doesn’t require altering the environment—just the act of navigation and discovery is enough. However, exploration must feel purposeful; players need to understand where they’re going and how the layout connects. Random or arbitrary navigation undermines the experience.",
	"For some players, exploration alone is rewarding—like uncovering every tile in Civilization before restarting. Others find exploration more engaging when tied to a purpose, such as searching for treasures, lore, or secrets. In both cases, exploratory agency enriches gameplay by fostering curiosity and the joy of discovery.",
	"The next area will be an example of exploratory agency. There is not really a goal other than to walk around. Now back to the story!",
	"You left the building after giving Joe his coins and answering his ultimatum. Now onto your daily walk!"
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
@onready var big = $BigText

func _ready():
	continue_label.text = "Click to continue: 1/" + str(len(narrative_texts))
	big.hide()
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
	# What to do when narrative ends
	# For example, change to next scene
	#GameManager.current_level = -3
	#GameManager.selected_level = -2
	#get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/Exploratory.tscn")
