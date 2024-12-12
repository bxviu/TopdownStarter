extends CharacterBase
class_name Spawner

@export var enemy_scene: PackedScene   # Drag and drop your enemy scene here in the Inspector
@export var spawn_interval: float = 2.0  # Time interval between spawns
@export var spawn_area: Rect2 = Rect2(Vector2.ZERO, Vector2(200, 200))  # Define the spawning area
@export var max_spawns: int = 10  # Maximum number of spawns
@export var parent: Node = self

var _spawn_timer: Timer
var _spawn_count: int = 0

func _ready():
	# Create and configure the timer
	_spawn_timer = Timer.new()
	_spawn_timer.wait_time = spawn_interval
	_spawn_timer.autostart = true
	_spawn_timer.one_shot = false
	_spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	add_child(_spawn_timer)

func _on_spawn_timer_timeout():
	if _spawn_count < max_spawns:
		spawn_enemy()
		_spawn_count += 1
	else:
		pass
		#_spawn_timer.stop()  # Stop the timer when the limit is reached

func spawn_enemy():
	if not enemy_scene:
		print("Enemy scene not set!")
		return

	# Instance the enemy
	var enemy_instance = enemy_scene.instantiate()

	# Randomize the spawn position within the spawn area
	var spawn_position = Vector2(
		randi() % int(spawn_area.size.x) + spawn_area.position.x,
		randi() % int(spawn_area.size.y) + spawn_area.position.y
	)

	enemy_instance.position = spawn_position

	# Add the enemy to the scene
	parent.add_child(enemy_instance)

		
func _die():
	super() #calls _die() on base-class CharacterBase
	
	queue_free()
