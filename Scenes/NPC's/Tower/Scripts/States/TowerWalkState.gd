extends State
class_name TowerWalking

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	pass

func Update(delta : float):
	Transition("Attacking")

#We cannot allow a transition before the dash is complete and the animation has stopped playing
func Transition(newstate : String):
	state_transition.emit(self, newstate)
