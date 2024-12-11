extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Challenge in games refers to progress that isn't easy or trivial, requiring the player to put in significant effort, skill, or understanding to advance. This can involve overcoming difficulty or friction, but it’s more than just persistence or luck; it rewards mastery of the game’s mechanics or systems. While challenge often doesn’t involve many significant choices beyond continuing the game, it plays a critical role in player agency by pushing them to exert effort for meaningful progress.",	
	"Historically, challenge was central to the appeal of video games. Many games reward fast reflexes, while others encourage learning and mastery, where players start with something difficult but eventually feel a sense of growth and accomplishment. This transition from non-grasp to grasp is key to challenge—mastering something difficult is often more satisfying than overcoming something easy. However, difficulty should be balanced to avoid frustrating players, while still offering a sense of progression.",	
	"In some cases, the sense of challenge is artificially constructed through increasing stats or memorizing levels. This gives the illusion of improving skills without substantial change in gameplay. The process of mastery in games is often easier compared to real-world skills, making games a more accessible outlet for those seeking the satisfaction of learning.",	
	"People tend to feel more invested in progress that is earned through overcoming challenges rather than being given for free. While some players enjoy challenge for its own sake, others prefer it to be tied to meaningful motivations, or may not care for challenge at all. Ultimately, while challenge is an essential part of many games, it’s not the defining factor that makes a game a game.",	
	"The level you just completed should have been a challenge. In previous levels, you could easily run through it and go to the exit door. In this level, it wasn't so trivial as you had to open the door first. Additionally, a bunch of enemies were trying to prevent you from completing your objective of unlocking the door, requiring you to have mastered the dashing system to dodge their attacks.",	
	"Back to the story, you are about to reach the portal summoning all the monsters. You must break it with your fists and kicks!"
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
	GameManager.current_level = 5
	GameManager.selected_level = 6
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
