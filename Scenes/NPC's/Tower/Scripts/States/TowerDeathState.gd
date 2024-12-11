extends State
class_name Tower_die_state

@export var animator : AnimationPlayer

func Enter():
	animator.play("Death")
