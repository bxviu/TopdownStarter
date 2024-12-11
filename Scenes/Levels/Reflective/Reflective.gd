extends Control

# Array of narrative text blocks
var narrative_texts = [
	"That was a reflective choice. No matter what decision you did, the same thing happened anyways. The NPC ended up taking your money.",
	"Reflective choices are decisions that don’t impact a game’s mechanics or story but instead reveal something about the protagonist’s internal state or provide context for the world. These choices don’t promise tangible consequences—they exist to let the player express an attitude, fill in backstory, or explore possibilities. Sometimes the act of declaring a preference or stance is more important than what follows.",
	"This type of choice relies on a deep connection between the player and the game. Reflective choices ask players to treat the game like a 'friendly ear,' sharing thoughts and feelings with no expectation of material reward. This is a delicate balance—if players feel invested, reflective choices can elevate the experience into something deeply personal. But if the game hasn’t already earned their trust, such choices may feel hollow or frustrating.",
	"The line between reflective choices and Big Decisions can blur, especially if the game unintentionally or intentionally disguises them. When a reflective choice is mistaken for a consequential one, it risks breaking the player’s trust, as Big Decisions come with an implicit promise of impact. Successfully implementing reflective choices requires subtlety, craft, and an audience already engaged with the game’s emotional and aesthetic layers. When done right, they can turn a good game into an unforgettable one.",
]

# Current text index
var current_text_index = 0

# Reference to the Label node
@onready var narrative_label = $InfoLabel
@onready var continue_label = $ContinueLabel
@onready var title = $Title
signal popup_closed

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
	emit_signal("popup_closed")
	# What to do when narrative ends
	# For example, change to next scene
	#get_tree().change_scene_to_file("res://next_scene.tscn")
