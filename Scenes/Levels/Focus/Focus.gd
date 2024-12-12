extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Focus in open-world games allows players to choose which aspects they’re interested in. This pick-and-mix approach helps tailor their experience, giving them control over their engagement with different elements of the game.",
	"Compelling focus choices involve selecting between interesting alternatives, rather than simple this-or-nothing scenarios. Focus choice is denied when a game forces players to engage with aspects they aren’t interested in or heavily favors one option, limiting genuine choice.",
	"Players can achieve focus agency by selecting games that align with their preferred aspects. While some games struggle with variable focus, sandbox and multiplayer games often excel, offering a more flexible and satisfactory gaming experience.",
	"An example of focus agency in this game is that there were multiple ways to achieve the goal of getting 100 coins. You could choose to focus on talking to NPCs, defeat monsters, or gather materials. Or you could've done a mixture of them.",
	"Back to the story, it turns out all the monsters you escaped from earlier are coming back with a vengeance! Good thing you gathered coins. You can build some defenses now!"
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
#signal popup_closed

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
	#emit_signal("popup_closed")
	# What to do when narrative ends
	# For example, change to next scene
	GameManager.current_level = 9
	GameManager.selected_level = 11
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://next_scene.tscn")
