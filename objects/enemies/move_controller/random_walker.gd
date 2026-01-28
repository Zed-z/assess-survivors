extends MoveController
class_name RandomWalker

var curent_target_location: Vector2 = Vector2.ZERO

@onready var spawner: EnemySpawner = $"../../.."

@export var speed : float = 40


func generate_valid_target_location():

	var temp_target_location : Vector2

	while true:
		for i in range(5):
			var offset = Vector2(1000,0).rotated(randf_range(0,3.14 * 2))
			var enemy_location= global_position + offset

			if spawner.is_position_inside_area(enemy_location):
				curent_target_location = enemy_location
				return
			else:
				enemy_location = global_position - offset

				if spawner.is_position_inside_area(enemy_location):
					curent_target_location = enemy_location
					return

		print("CANT GENERATE NEW LOCATION")
		await get_tree().process_frame


func _ready() -> void:
	generate_valid_target_location()


func get_velocity() -> Vector2:

	if global_position.distance_squared_to(curent_target_location) < 50:
		generate_valid_target_location()

	var dir = (curent_target_location - global_position).normalized()

	return dir * speed
