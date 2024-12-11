# StartScreen.gd
extends Control

func _ready():
	# Ensure the buttons are connected to their respective functions
	$StartButton.connect("pressed", Callable(self, "_on_start_button_pressed"))
	$QuitButton.connect("pressed", Callable(self, "_on_quit_button_pressed"))

# Function called when the Start button is pressed
func _on_start_button_pressed():
	# Replace "res://main_game_scene.tscn" with the path to your main game scene
	get_tree().change_scene_to_file("res://Scenes/Levels/Introduction/Intro.tscn")

# Function called when the Quit button is pressed
func _on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
