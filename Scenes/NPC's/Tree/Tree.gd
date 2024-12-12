extends CharacterBase

		
func _die():
	super() #calls _die() on base-class CharacterBase
	
	queue_free()
