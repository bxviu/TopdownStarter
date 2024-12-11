extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Grasp is the ability to understand and control the world within a game. It’s the feeling of manipulating elements—whether by moving objects, mastering mechanics, or intuitively knowing how things work. It’s not just about skill; it’s about understanding the rules of the world and how your actions impact it, whether through gameplay mechanics or narrative context. A player with grasp feels in control and aware of how their actions affect the world, creating a sense of agency.",
	"Grasp also connects to motivational alignment, where the player’s in-game goals match the character's fictional motivations. This creates a seamless experience where gameplay rewards align with role-playing choices, making the game feel more immersive and empowering. However, if players discover inconsistencies, like exploiting game mechanics that don’t fit with the story, the feeling of agency shifts from being a character to being a user manipulating a system.",
	"While grasp is satisfying when gameplay and narrative align, it can also lead to formulaic power-fantasy stories, where the player gradually gains more power. This can make the game feel predictable, though it’s still enjoyable for many players. The challenge lies in balancing grasp with deeper, more complex narratives that don’t just reward power growth but provide a richer sense of agency.",
	"In this game, the example of grasp is the player character slowly unlocking more abilities. Such as dashing, to explore areas faster or to dodge attacks, or attacking, with fists and kicks."
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
	# What to do when narrative ends
	# For example, change to next scene
	GameManager.current_level = 3
	GameManager.selected_level = 4
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
