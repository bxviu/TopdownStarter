extends Node

const LEVELOFFSET = -3

var money = 0
var selected_level = LEVELOFFSET
var current_level = LEVELOFFSET
var linear = true

var playerAttacks = false
var playerDash = false

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
	
