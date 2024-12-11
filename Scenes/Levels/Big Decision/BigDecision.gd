extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Big Decisions are prominent, dramatic choices in games, often marketed as central to the experience. These are moments where players face clear, ethical dilemmas with seemingly major, irreversible consequences, such as choosing between good and evil factions or sparing or killing a key character. They stand out, sometimes using special mechanics like multiple-choice prompts to emphasize their importance.",
	"Games like The Walking Dead often frame most player decisions as Big Decisions, though their actual impact can range from story-altering to simple stat changes. At their extreme, these choices define gameplay entirely, like in Choose-Your-Own-Adventure stories.",
	"Big Decisions have clear advantages: they’re dramatic, explicit, and great for discussing ethics in games. However, they risk overpromising on their consequences or revealing the limitations of binary choices, which can break immersion. They’re also often used to determine endings, which may feel satisfying but can overshadow the importance of the journey or gameplay process. While they can be powerful, reliance on them can make agency feel shallow or contrived.",
	"Now, back to Joe's Ultimatum, you have the choice of becoming an omnipotent being, manipulating time (through being able to directly choose the next level) or continue staying a normal human and progress linearly through the story."
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var omnipotence_button = $OmnipotenceButton
@onready var normal_button = $NormalButton
@onready var title = $Title

func _ready():
	continue_label.text = "Click to continue: 1/" + str(len(narrative_texts))
	omnipotence_button.hide()
	normal_button.hide()
	title.modulate = GameManager.textColor
	narrative_label.modulate = GameManager.textColor
	continue_label.modulate = GameManager.textColor
	# Show first text block
	show_next_text()
	
	# Enable input processing
	set_process_input(true)
	$OmnipotenceButton.connect("pressed", Callable(self, "_on_omnipotence_button_pressed"))
	$NormalButton.connect("pressed", Callable(self, "_on_normal_button_pressed"))

# Function called when the Start button is pressed
func _on_omnipotence_button_pressed():
	GameManager.linear = false
	# Replace "res://main_game_scene.tscn" with the path to your main game scene
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")

# Function called when the Quit button is pressed
func _on_normal_button_pressed():
	GameManager.current_level = -2
	GameManager.selected_level = -1
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	
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
	# What to do when narrative ends
	# For example, change to next scene
	#get_tree().change_scene_to_file("res://next_scene.tscn")
	omnipotence_button.show()
	normal_button.show()
