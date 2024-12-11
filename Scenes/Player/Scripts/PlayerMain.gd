extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as FiniteStateMachine
const DEATH_SCREEN = preload("res://Scenes/Misc/DeathScreen.tscn")
@onready var hitbox = $BodyCollisionShape/Area2D

var blockHealing = false
#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _die():
	super() #calls _die() on base-class CharacterBase
	
	fsm.force_change_state("Die")
	var death_scene = DEATH_SCREEN.instantiate()
	add_child(death_scene)

func _process(delta):
	super(delta)
	# Get all overlapping bodies
	var overlapping_bodies = hitbox.get_overlapping_areas()
	#print(overlapping_bodies)
	for body in overlapping_bodies:
		if !blockHealing and body.is_in_group("Healing"):
			#print("Target is inside the hitbox!")
			if self.health < self.healthbar.max_value:
				self.health += 3
				self.healthbar.value = self.health;
			blockHealing = true
			await get_tree().create_timer(0.5).timeout
			blockHealing = false

				
