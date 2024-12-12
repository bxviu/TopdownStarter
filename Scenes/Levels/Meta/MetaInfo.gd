extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Wow! You just switched locations and easily got away from those monsters, through 'editing' the files! (the button prompt was supposed to represent that). This is an example of Meta agency, as you took control and 'edited' the game to leave a level.",
	"In authored games, the design is primarily the province of the author. While emergent play happens within the space delineated by the designer, true creative control remains with the author. In contrast, tabletop RPGs allow the GM to directly respond to player concerns and even hand over creative authority, which is not yet possible in videogames.",
	"Players can make mods, but this isn't considered part of the game by definition. Even in-game level editors work within author-defined limits. However, game creators don't operate in a vacuum. Players develop a sense of the concerns of the creators, and a lot of agency arises from trust in the author. This relationship can be quite concrete, especially in the era of Kickstarter.",
	"Cheating, whether through paying for extra turns, editing game files, or using walkthroughs, gives players a direct kind of control over the game. This is often part of the intended experience for monetization or to ease the learning curve. Wikis and player-made tutorials help games like Minecraft, allowing the creators to focus less on in-game tutorials.",
	"A sense of agency in games is a positive feedback loop. The kinds of agency offered create an impression of what the author cares about. For example, if a game caters only to straight men or is hostile to women, female players' expectations of agency diminish. Trust in the game's design is crucial and easily damaged, affecting the overall experience.",
	"Political or religious games are challenging to get right because players can feel compelled to follow the author's values, disregarding their own answers. Games that do not ignore marginalized groups confer more meta-agency. Reactions to games like Gone Home highlight the importance of representation and how it can enhance the player's experience of agency.",
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
	GameManager.current_level = 7
	GameManager.selected_level = 8
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/Exploratory.tscn")
