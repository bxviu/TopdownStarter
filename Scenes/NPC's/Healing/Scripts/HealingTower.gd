extends CharacterBase
class_name HealingTower

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _die():
	super() #calls _die() on base-class CharacterBase
	
	queue_free()
