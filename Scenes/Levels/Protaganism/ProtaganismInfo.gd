extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Protagonism is the sense that the player-character is central to the story—its driving force and focus. Many games amplify this to extremes, using 'Chosen One' plots or making the protagonist responsible for nearly every major event. This appeals to players' desire to feel important and influential, though it can sometimes come across as excessive or even indulgent.",
	"Protagonism isn’t strictly about choice; even in games where players don’t direct the story, they remain the focal point. It’s a key part of agency because it gives players a sense of personal investment. For example, even ancient board games like Snakes and Ladders—which lack meaningful player choice—offered protagonism by placing importance on the player’s token and its journey. These games were popular because they gave players a feeling of ownership over the narrative, whether moral, spiritual, or personal.",
 	"A subtler form of protagonism is narrative action, where the player’s activities are significant to the story. Even if the player isn’t the most important figure, their contributions matter, ensuring the story revolves around what they do rather than sidelining them entirely. Protagonism, in its various forms, ensures players feel engaged and connected to the game’s narrative.",
	"For example, collecting coins in this little game to progress. The NPC, Joe, wouldn't do anything and it was up to the player character to collect and give the coins to Joe.",
	"Since you helped Joe, he offers you an ultimatum before leaving the building. You could call it a..."
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
	GameManager.current_level = -3
	GameManager.selected_level = -2
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
