extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Velocity refers to the alignment between the story’s progression and the player's experience. It’s the sense that the events unfolding in the game world match the emotional or narrative arc the player is experiencing. This connection between play and story doesn’t need to be strictly linear or directly cause-and-effect, but when the two move together, it creates a more immersive and satisfying experience.",	
	"One way to achieve velocity is by increasing the intensity of gameplay as the narrative becomes more intense, but this approach has challenges. If difficulty spikes at climactic moments (like boss fights), it can disrupt the flow of the story, forcing the player to repeat sections and breaking immersion. Gameplay intensity can also distract from the narrative if not handled well.",	
	"The key is balance: when gameplay and narrative feel disconnected, like when the story halts for hours of unrelated tasks (such as grinding), it weakens the emotional connection to the plot. If the gameplay style doesn’t support the pacing of the narrative, the player might lose interest in the story altogether. Velocity works best when gameplay and narrative evolve in harmony, allowing players to stay engaged with both the mechanics and the unfolding events.",	
	"For example, the character has found some survivors, and they provide him with information that he can stop these monsters by dealing with their portal in the basement. The level is also more difficult, as the player is getting closer to the original location of the monsters, so there are more clumped together.",	
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
	GameManager.current_level = 4
	GameManager.selected_level = 5
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
