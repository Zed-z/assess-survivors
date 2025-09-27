extends Node2D
class_name EnemySpawner

@export var player: Player

@export_group("spawn parameters")
@export var min_radius: float = 100
@export var max_radius: float = 200
@export var enemy: PackedScene
#region vaves
@export_group("enemy veaves ")
## key is level at whitch it is beeing spawned
##value is value data representing probability of certain enemiy to spawn
@export var vaves: Dictionary[int, VaveData]
var current_vave_data: VaveData
var cached_probabilities: Array[float]

var enemies_array: SwapbackArray


func create_enemy()->Node2D:
	var index = MathUtils.choices_1f(cached_probabilities)
	return current_vave_data.enemies[index].scene.instantiate()


func on_player_new_level(level: int):
	var data = vaves.get(level)
	print("AAAAA level ",level)
	if data != null:
		print("bbbbbb")
		cached_probabilities = data

#endregion vaves

signal enemy_killed(int)


func _ready() -> void:
	enemies_array = SwapbackArray.new(50)
	GlobalInfo.enemy_spawner = self

	current_vave_data = vaves[0]
	cached_probabilities = []

	for value:VaveTouple in current_vave_data.enemies:
		cached_probabilities.append(value.probability)

	player.get_node("Levels").connect("new_level",on_player_new_level)


func remove_enemy(enemy_to_kill):
	var y = enemies_array.erase(enemy_to_kill)

	if y:
		y.queue_free()
		enemy_killed.emit(1)


func _process(_delta: float) -> void:

	if enemies_array.size() < 200:
		var radius = randf_range(min_radius,max_radius)
		var offset = Vector2(radius,0).rotated(randf_range(0,3.14 * 2))
		var e: Node2D = create_enemy()

		add_child(e)
		enemies_array.append(e)
		e.global_position = player.global_position + offset
