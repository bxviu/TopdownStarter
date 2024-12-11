extends State
class_name PlayerWalking

@export var movespeed := int(350)
@export var dash_max := int(500)
var dashspeed := float(100)
var can_dash := bool(false)
var dash_direction := Vector2(0,0)

var player : CharacterBody2D
@export var animator : AnimationPlayer
@onready var hitbox = $"../../BodyCollisionShape/Area2D"
var speed = false

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("Walk")

func Update(delta : float):
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	Move(input_dir)
	LessenDash(delta)

	if (Input.is_action_just_pressed("Dash") && can_dash && GameManager.playerDash):
		start_dash(input_dir)

	if (GameManager.playerAttacks):
		if (Input.is_action_just_pressed("Punch") or Input.is_action_just_pressed("Kick")):
			Transition("Attacking")
			
func _process(delta):
	# Get all overlapping bodies
	var overlapping_bodies = hitbox.get_overlapping_areas()

	#print(overlapping_bodies)
	speed = false
	for body in overlapping_bodies:
		if body.is_in_group("SpeedBoost"):
			speed = true
			#print("Target is inside the hitbox!")
			break
	if speed:
		movespeed = 280
	else:
		movespeed = 140
	
func Move(input_dir : Vector2):
	#Suddenly turning mid dash
	if(dash_direction != Vector2.ZERO and dash_direction != input_dir):
		dash_direction = Vector2.ZERO
		dashspeed = 0

	player.velocity = input_dir * movespeed + dash_direction * dashspeed 
	player.move_and_slide()

	if(input_dir.length() <= 0):
		Transition("Idle")

func start_dash(input_dir : Vector2):
	AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, -1)
	dash_direction = input_dir.normalized()
	dashspeed = dash_max
	animator.play("Dash")
	can_dash = false

func LessenDash(delta : float):
	#Higher multiplier values makes the dash shorter
	var multiplier : float = 4.0
	var timemultiplier : float = 4.1
	
	#slow down the dash over time, both as a fraction of dashspeed and also time
	#While clamping it between 0 and dash_max
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	dashspeed = clamp(dashspeed, 0, dash_max)
	
	if(dashspeed <= 0):
		can_dash = true
		dash_direction = Vector2.ZERO
		
	if(animator.current_animation == "Dash"):
		await animator.animation_finished
		animator.play("Walk")

#We cannot allow a transition before the dash is complete and the animation has stopped playing
func Transition(newstate : String):
	if(dashspeed <= 0):
		state_transition.emit(self, newstate)
