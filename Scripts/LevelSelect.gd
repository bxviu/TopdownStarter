extends Control

var selected_level = 0  # The index of the currently selected level
const SCALE_CENTER = 1.2  # Scale for the centered level
const SCALE_OTHER = 0.8  # Scale for other levels

@onready var levels = $VBoxContainer.get_children()  # List of all level nodes
@onready var scroll_speed = 0.2  # Speed for smooth scrolling

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_level_display()
	print(levels)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	# Handle input to move selection up or down
	if event.is_action_pressed("ui_down") and selected_level < len(levels) - 1:
		selected_level += 1
		update_level_display()
	elif event.is_action_pressed("ui_up") and selected_level > 0:
		selected_level -= 1
		update_level_display()

func update_level_display():
	print("moving")
	print(selected_level)
	# Iterate through each level and adjust their size and position
	for i in range(len(levels)):
		if i == selected_level:
			# Centered level
			#levels[i].rect_scale = Vector2(SCALE_CENTER, SCALE_CENTER)
			levels[i].modulate = Color(1, 1, 1)  # Fully visible
		else:
			# Other levels
			#levels[i].rect_scale = Vector2(SCALE_OTHER, SCALE_OTHER)
			levels[i].modulate = Color(0.7, 0.7, 0.7)  # Dimmed
		# Smoothly scroll the VBoxContainer
		$VBoxContainer.move_child(levels[i], i - selected_level)
