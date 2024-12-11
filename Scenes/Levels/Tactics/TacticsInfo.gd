extends Control

# Array of narrative text blocks
var narrative_texts = [
	"Tactics are ways of accomplishing an objective in games. They involve making decisions that affect the immediate outcome. For example, in many action games, beating a boss requires learning its pattern and finding the right way to counter it. Tactics mean having control over small details that combine into bigger results.",
	"Strategic agency occurs when players can create and benefit from long-term plans involving multiple steps. This might be in service of larger goals or independent objectives. Strategy often involves higher-level decisions and freedom in crafting approaches.",
	"Tactical agency is about behaving differently to achieve different useful results. In games like rail shooters versus FPS with linear level design, tactics provide control over actions and the ability to develop various strategies to succeed.",
	"Games often balance tactics and strategy differently. For example, XCOM: Enemy Unknown focuses more on tactical decisions, while 80 Days provides more strategic freedom. Understanding the balance in each game helps players craft their approaches.",
	"In the previous battle you just completed, there are many ways to defeat the portal. You could have rushed at it and ignored everything attacking you, or maybe you took a more strategic approach and summoned some helper buildings to aid you.",
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
	GameManager.current_level = 6
	GameManager.selected_level = 7
	get_tree().change_scene_to_file("res://Scenes/Levels/LevelSelect.tscn")
	#get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
