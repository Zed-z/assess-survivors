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
@export var vaves: VaveCollection
var current_vave_index = 0
var current_vave_data: VaveData
var cached_probabilities: Array[float]
var timer: SceneTreeTimer
var counted_enemies = 0
var spawned_enemies =0

var enemies_array: SwapbackArray
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer


func create_enemy()->Node2D:
	var index = MathUtils.choices_1f(cached_probabilities)
	return current_vave_data.enemies[index].scene.instantiate()


func new_vave():

	print("new wejw")
	var data = vaves.vaves.get(current_vave_index)

	if data != null:

		current_vave_data = data
		cached_probabilities = []

		for value:VaveTouple in current_vave_data.enemies:
			cached_probabilities.append(value.probability)

		if timer:
			timer.unreference()

		counted_enemies = 0

		if data.kill_all_enemies:
			pass
		elif data.vave_duration > 0:
			timer = get_tree().create_timer(data.vave_duration)
			timer.timeout.connect(


				func x():
					current_vave_index +=1
					new_vave()
					)

		enemy_spawn_timer.wait_time = 60.0 / current_vave_data.enemies_per_minute
		enemy_spawn_timer.start()
#endregion vaves

signal enemy_killed(enemy: Enemy)


func _ready() -> void:
	enemy_spawn_timer.timeout.connect(spawn_enemy)
	enemies_array = SwapbackArray.new(50)
	GlobalInfo.enemy_spawner = self

	current_vave_data = vaves.vaves[0]
	cached_probabilities = []

	for value:VaveTouple in current_vave_data.enemies:
		cached_probabilities.append(value.probability)

	new_vave()


func remove_enemy(enemy_to_kill):
	var killed_enemy: Enemy = enemies_array.erase(enemy_to_kill) as Enemy

	if not killed_enemy:
		return

	if killed_enemy.vave_number == current_vave_index:
		counted_enemies += 1

		if current_vave_data.kill_all_enemies:

			if counted_enemies >= current_vave_data.enemies_to_spawn:
				current_vave_index+=1
				new_vave()

	enemy_killed.emit(killed_enemy)
	killed_enemy.queue_free()


func spawn_enemy():

	if not enemies_array.size() < current_vave_data.enemy_cap:
		return

	if spawned_enemies >= current_vave_data.enemies_to_spawn and current_vave_data.enemies_to_spawn > 0:
		return

	spawned_enemies += 1
	var radius = randf_range(min_radius,max_radius)
	var offset = Vector2(radius,0).rotated(randf_range(0,3.14 * 2))
	var e: Node2D = create_enemy()

	add_child(e)
	enemies_array.append(e)
	e.global_position = player.global_position + offset
	e.vave_number = current_vave_index


func _process(_delta: float) -> void:
	pass
