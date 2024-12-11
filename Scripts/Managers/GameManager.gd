extends Node

# Global popup handler
var popup_scene = null
var active_popup = null

const LEVELOFFSET = -3

var money = 0
var selected_level = LEVELOFFSET
var current_level = LEVELOFFSET
var linear = true

var textColor = Color(255,255,0)
#var textColor = Color(255,255,255)

var playerAttacks = false
var playerDash = false

signal interacted_with(object)
signal quest_progress(quest_name, progress)
signal quest_finish(quest_name)

#NOTE This class is our game manager and handles the players money and loading scenes
#These functions can be called globally from anywhere

func reset_money():
	money = 0

func add_money(addmoney : int):
	money += addmoney

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)

func load_same_level():
	get_tree().reload_current_scene()
	
func change_level(level : int):
	selected_level = level
	
# Show a popup based on a given scene path and a parent node to attach it to
func show_popup(popup_scene_path: String, parent: Node, position: Vector2 = Vector2(-320, -180)):
	if active_popup:
		return # Prevent showing multiple popups at once

	# Load the popup scene
	popup_scene = ResourceLoader.load(popup_scene_path)
	active_popup = popup_scene.instantiate()

	# Add the popup to the specified parent and set its position
	parent.add_child(active_popup)
	active_popup.position = position
	active_popup.z_index = 2

	# Pause the main scene
	get_tree().paused = true

	# Connect to the custom signal to unpause and clean up
	active_popup.connect("popup_closed", Callable(self, "_on_popup_closed"))

# Handle cleanup when the popup is closed
func _on_popup_closed():
	# Unpause the main scene
	get_tree().paused = false
	active_popup.queue_free()
	active_popup = null
