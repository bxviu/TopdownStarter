extends Node2D

@onready var quest_finish = $Scene/Quests/QuestFinish
@onready var NPC1 = $NPCs/NPC
@onready var NPC2 = $NPCs/NPC2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("quest_progress", Callable(self, "_on_quest_progress"))
	GameManager.connect("quest_finish", Callable(self, "_on_quest_finish"))
	NPC2.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_quest_progress(quest_name: String, progress: float):
	# Handle the quest progress update
	print("Quest ", quest_name, " is now at step ", progress, ".")
	
	# Example of different actions based on quest progress
	match quest_name:
		"Joe needs Coins":
			if progress == 3:
				print("got enough coins")
				# Trigger reward, unlock next quest, etc.
				quest_finish.position.x = -172
				NPC1.hide()
				NPC2.show()
		_:
			print("Unhandled quest progress")

func _on_quest_finish(quest_name: String):
	# Handle the quest progress update
	print("Quest ", quest_name, " done.")
	
	# Example of different actions based on quest progress
	match quest_name:
		"Joe needs Coins":
			GameManager.add_money(-5)
			await get_tree().create_timer(2.5).timeout
			get_tree().change_scene_to_file("res://Scenes/Levels/Protaganism/ProtaganismInfo.tscn")
		_:
			print("Unhandled quest progress")
