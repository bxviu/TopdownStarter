extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Creative agency in games involves remixing materials within set rules. Tabletop RPGs excel at this, while computer games often offer less creative freedom. Creative choices can range from aesthetic decisions, like costume design in The Sims 3, to impactful designs in Minecraft or Dwarf Fortress.",
	"In games where creative agency isn't central, it often leans towards aesthetic choices. For example, Skyrim's house-building expansion primarily involves selecting components from lists, offering less creative freedom than it suggests. Allowing meaningful creative choice typically requires significant effort.",
	"Even in games focused on creativity, author-defined rules always limit creative agency. This doesn't mean it's illusory; all agency is bounded by the creators' concerns. While creative-agency games aren't necessarily transformative, they still offer valuable experiences within their limits.",
	"In the game you just played, you had creative agency in how you placed the towers, or if you even used them! The combination of towers you could place can directly affect how your gameplay was.",
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
	get_tree().change_scene_to_file("res://Scenes/Levels/Ending/Ending.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
