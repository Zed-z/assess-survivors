extends Node2D
class_name EnemySpawner

signal enemy_killed(enemy: Enemy)

@export var player: Player
@export_group("spawn parameters")
@export var min_radius: float = 100
@export var max_radius: float = 200
@onready var timer: Timer = $WaveTimer
var use_timer : bool

#region waves
@export_group("enemy veaves ")
## key is level at whitch it is beeing spawned
##value is value data representing probability of certain enemiy to spawn
@export var waves: WaveCollection
var current_wave_index = 0
var current_wave_data: WaveData
var cached_probabilities: Array[float]
var counted_enemies = 0
var spawned_enemies =0

var enemies_array: SwapbackArray
@onready var enemy_spawn_timer: Timer = $EnemySpawnTimer
@onready var spawnable_area: CollisionPolygon2D = $SpawnableArea

var endles_wave_timer : Timer


func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("force_next_wave"):
		current_wave_index+=1
		current_wave_index = clamp(current_wave_index,0,len(waves.waves))
		print(current_wave_index)
		new_wave()

	if event.is_action("restart_wave"):
		new_wave()
		for enemy:Enemy in enemies_array:
			if is_instance_valid(enemy):
				enemy.wave_number = -1

	if event.is_action("previous_wave"):
		current_wave_index-=1
		current_wave_index = clamp(current_wave_index,0,len(waves.waves))
		new_wave()

		for enemy:Enemy in enemies_array:
			if is_instance_valid(enemy):
				enemy.wave_number = -1


func create_enemy()->Enemy:
	var index = MathUtils.choices_1f(cached_probabilities)
	return current_wave_data.enemies[index].scene.instantiate()


func new_wave():

	var data = waves.waves.get(current_wave_index)

	if data != null:

		current_wave_data = data
		cached_probabilities = []

		for value: WaveTouple in current_wave_data.enemies:
			cached_probabilities.append(value.probability)

		counted_enemies = 0
		spawned_enemies = 0

		if data.is_endless:
			assert(not current_wave_data.kill_all_enemies, "endless wave cannot demmand player kills all enemies")
			use_timer = false
			endles_wave_timer = Timer.new()
			endles_wave_timer.autostart = true
			endles_wave_timer.wait_time = 10


			endles_wave_timer.timeout.connect(func x():
				current_wave_data.enemies_per_minute += current_wave_data.enemies_per_munite_incease
				current_wave_data.enemy_cap += current_wave_data.enemy_cap_increase
				print("values scaled")
				enemy_spawn_timer.wait_time = 60.0 / current_wave_data.enemies_per_minute

				)

			add_child(endles_wave_timer)
		elif data.kill_all_enemies:
			use_timer = false
		elif data.wave_duration > 0:
			use_timer = true
			timer.wait_time = data.wave_duration

		enemy_spawn_timer.wait_time = 60.0 / current_wave_data.enemies_per_minute
		enemy_spawn_timer.start()

	else:
		current_wave_data = null
#endregion waves


func _ready() -> void:
	enemy_spawn_timer.timeout.connect(spawn_enemy)
	enemies_array = SwapbackArray.new(50)
	GlobalInfo.enemy_spawner = self

	current_wave_data = waves.waves[0]
	cached_probabilities = []

	for value: WaveTouple in current_wave_data.enemies:
		cached_probabilities.append(value.probability)

	timer.timeout.connect(


				func x():
					current_wave_index +=1
					new_wave()
					)

	new_wave()


func remove_enemy(enemy_to_kill):
	var killed_enemy: Enemy = enemies_array.erase(enemy_to_kill) as Enemy

	if not killed_enemy:
		return

	if killed_enemy.wave_number == current_wave_index:
		counted_enemies += 1

		if current_wave_data.kill_all_enemies and not current_wave_data.is_endless:

			if counted_enemies >= current_wave_data.enemies_to_spawn:
				current_wave_index+=1
				new_wave()

	enemy_killed.emit(killed_enemy)

	killed_enemy.queue_free()


func spawn_enemy():

	#we fuinished all the waves so we cannot spawn anything
	if current_wave_data == null:
		return

	#we  reched the maximum number of enemies on the screen
	if not enemies_array.size() < current_wave_data.enemy_cap:
		return

	#all enemies that belonged to the wave have been spawned
	if spawned_enemies >= current_wave_data.enemies_to_spawn and current_wave_data.enemies_to_spawn > 0 \
	and current_wave_data.kill_all_enemies:
		return

	spawned_enemies += 1
	var e: Enemy = create_enemy()

	var enemy_location

	var scaler = current_wave_data.scaling

	e.scale_enemy(scaler)

	#a crude way of making enemies appear only on land
	#ALERT: will not work when map is small
	var spawn_try_tally := 0

	while true:
		var radius = randf_range(min_radius,max_radius)
		var offset = Vector2(radius,0).rotated(randf_range(0,3.14 * 2))
		enemy_location= player.global_position + offset

		if not Geometry2D.is_point_in_polygon(to_local(enemy_location),spawnable_area.polygon):
			enemy_location = player.global_position - offset

		spawn_try_tally += 1

		if spawn_try_tally > 10:
			printerr("tried to spawn enemy multiple times without succes")
			return

		break

	call_deferred("add_child",e)
	enemies_array.append(e)
	e.global_position = enemy_location
	e.wave_number = current_wave_index


func is_position_inside_area(pos: Vector2) ->bool:

	return Geometry2D.is_point_in_polygon(to_local(pos),spawnable_area.polygon)

var icon_wave_time: CompressedTexture2D = preload("res://sprites/ui/wave/stoper.png")
var icon_wave_kill: CompressedTexture2D = preload("res://sprites/ui/wave/skull.png")


func _process(_delta: float) -> void:
	if current_wave_data:
		GlobalInfo.combat_ui_overlay.wave_icon.visible = true

		GlobalInfo.combat_ui_overlay.wave_icon.texture = icon_wave_time if use_timer else icon_wave_kill

		GlobalInfo.combat_ui_overlay.wave_number_label.text = "Wave %s" % [current_wave_index + 1]

		GlobalInfo.combat_ui_overlay.wave_label.text = current_wave_data.get_status(counted_enemies,timer.time_left if timer else 0.0)
	else:
		GlobalInfo.combat_ui_overlay.wave_icon.visible = false
		GlobalInfo.combat_ui_overlay.wave_number_label.visible = false
		GlobalInfo.combat_ui_overlay.wave_label.text = "all waves finished"
