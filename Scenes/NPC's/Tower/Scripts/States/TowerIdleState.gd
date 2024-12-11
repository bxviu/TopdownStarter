extends State
class_name TowerIdle

@export var animator : AnimationPlayer

func Enter():
	#animator.play("Attack")
	pass
	
func Update(_delta : float):		
	state_transition.emit(self, "Attacking")
