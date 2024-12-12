extends Control

var selected_level = GameManager.selected_level # The index of the currently selected level
var current_level = GameManager.current_level # The index of the currently selected level
const SCALE_CENTER = 1.2  # Scale for the centered level
const SCALE_OTHER = 0.8  # Scale for other levels
var timing = false

@onready var levels = $MainVBox.get_children()  # List of all level nodes
@onready var scroll_speed = 0.2  # Speed for smooth scrolling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_level_display()	
	if (GameManager.linear && current_level != selected_level):
		update_level_display_delayed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if (timing):
		return
	# Handle input to move selection up or down
	if event.is_action_pressed("ui_down") and selected_level < len(levels) - 4:
		selected_level += 1
		current_level += 1 
		update_level_display()
	elif event.is_action_pressed("ui_up") and selected_level > -3:
		selected_level -= 1
		current_level -= 1
		update_level_display()
	elif event.is_action_pressed('accept'):
		enter_level()
	update_manager_levels()

func update_manager_levels():
	GameManager.current_level = selected_level
	GameManager.selected_level = selected_level

# Async function for smooth level update
func update_level_display_delayed():
	timing = true
	# Await a short delay before updating
	await get_tree().create_timer(0.75).timeout
	current_level = selected_level
	update_manager_levels()
	update_level_display()
	# Await a short delay before updating
	await get_tree().create_timer(2.5).timeout
	enter_level()

func update_level_display():
	# Iterate through each level and adjust their size and position
	for i in range(len(levels)):
		if i == (current_level + 3) % len(levels):
			# Centered level
			#levels[i].rect_scale = Vector2(SCALE_CENTER, SCALE_CENTER)
			levels[i].modulate = Color(1, 1, 1)  # Fully visible
		else:
			# Other levels
			#levels[i].rect_scale = Vector2(SCALE_OTHER, SCALE_OTHER)
			levels[i].modulate = Color(0.25, 0.25, 0.25)  # Dimmed
		# Smoothly scroll the VBoxContainer
		$MainVBox.move_child(levels[i], i - current_level)

func enter_level():
	match selected_level:
		-3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Protaganism/Protaganism.tscn")
		-2:
			get_tree().change_scene_to_file("res://Scenes/Levels/Big Decision/BigDecision.tscn")
		-1:
			get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/ExploratoryInfo.tscn")
		0:
			get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/ExploratoryInfo.tscn")
		1:
			get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/ExploratoryInfo.tscn")
		2:
			get_tree().change_scene_to_file("res://Scenes/Levels/Exploratory/ExploratoryInfo.tscn")
		3:
			get_tree().change_scene_to_file("res://Scenes/Levels/Grasp/Grasp.tscn")
		4:
			get_tree().change_scene_to_file("res://Scenes/Levels/Velocity/Velocity.tscn")
		5:
			get_tree().change_scene_to_file("res://Scenes/Levels/Challenge/Challenge.tscn")
		6:
			get_tree().change_scene_to_file("res://Scenes/Levels/Tactics/Tactics.tscn")
		7:
			get_tree().change_scene_to_file("res://Scenes/Levels/Meta/Meta.tscn")
		8:
			get_tree().change_scene_to_file("res://Scenes/Levels/Possibility/Possibility.tscn")
		9:
			get_tree().change_scene_to_file("res://Scenes/Levels/Possibility/Possibility.tscn")
		10:
			get_tree().change_scene_to_file("res://Scenes/Levels/Possibility/Possibility.tscn")
		11:
			get_tree().change_scene_to_file("res://Scenes/Levels/Creative/Creative.tscn")
		12:
			get_tree().change_scene_to_file("res://Scenes/Levels/Creative/Creative.tscn")

		
