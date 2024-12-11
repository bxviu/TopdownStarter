extends Control

@onready var color_picker = $ColorPickerButton  # Your color picker node
@onready var narrative_label = $InfoLabel
signal popup_closed

func _on_color_changed(new_color: Color):
	#print(new_color)
	GameManager.textColor = new_color
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_picker.connect("color_changed", Callable(self, "_on_color_changed"))
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	narrative_label.modulate = GameManager.textColor
	pass

func _on_confirm_button_pressed() -> void:
	emit_signal("popup_closed")
