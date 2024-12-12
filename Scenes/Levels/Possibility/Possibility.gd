extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Exploration in games pulls on the sense of possibility, giving players the liberating feeling that many things await. Open-world or sandbox games thrive on this sense, combining actual and implied in-game freedom. Mystery expands worlds, making them feel bigger and more intriguing.",	
	"The sense of possibility is crucial in both games and static fiction, like Tolkien's works. It's about the unknown options or outcomes to be discovered, and the confidence that finding them is possible. This sense can be sustained by having a lot of content or skillful design.",	
	"As players learn more about a game, their sense of possibility tends to decrease. Mastery can confine players to best practices, making experimentation less necessary. For some players, possibility is a challenge to overcome, while others value exploration and discovery.",	
	"Players have different priorities. Some prefer using walkthroughs to ensure they don't miss anything, similar to using a guidebook in a new city. Others value exploration and feel that being told where to go would ruin the experience. Player preferences shape how they engage with possibility in games.",	
	"Now, you have transported your character to a new area. This is an example of exploratory agency as there are many things to see and explore! In this new area, there are 4 other agencies that you must find.",	
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title

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
	#continue_label.hide()
	# What to do when narrative ends
	# For example, change to next scene
	get_tree().change_scene_to_file("res://Scenes/Levels/Possibility/Grasslands.tscn")
