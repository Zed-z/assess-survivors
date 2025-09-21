extends Node2D
class_name EnemySpawner

@export var player: Player

@export_group("spawn parameters")
@export var min_radius: float = 100
@export var max_radius: float = 200
@export var enemy: PackedScene

var enemies_array: SwapbackArray

signal enemy_killed(int)


func _ready() -> void:
	enemies_array = SwapbackArray.new(50)
	GlobalInfo.enemy_spawner = self


func remove_enemy(enemy_to_kill):
	var y = enemies_array.erase(enemy_to_kill)

	if y:
		y.queue_free()
		enemy_killed.emit(1)


func _process(_delta: float) -> void:

	if enemies_array.size() < 200:
		var radius = randf_range(min_radius,max_radius)
		var offset = Vector2(radius,0).rotated(randf_range(0,3.14 * 2))
		var e: Node2D = enemy.instantiate()

		add_child(e)
		enemies_array.append(e)
		e.global_position = player.global_position + offset
