extends Node2D

@export var projectile: PackedScene
@export var projectile_speed: float = 200

@export var stats: PlayerStats

var user_action: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			user_action = true

		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			user_action = false


func _process(delta: float) -> void:
	if user_action:
		if $Cooldown.time_left == 0:
				$Cooldown.wait_time = Utils.map_cooldown(stats.get_stat("STAT_COOLDOWN"))
				$Cooldown.start()

				var aim_direction: Vector2 = (get_global_mouse_position() - global_position)
				var direction: Vector2 = aim_direction.normalized() * projectile_speed

				shoot_projectile(direction)


func shoot_projectile(direction: Vector2):
	var proj: ProjectilePlayer = projectile.instantiate() as ProjectilePlayer
	proj.pierce_left = stats.get_stat("STAT_PIERCE")
	proj.damage = stats.get_stat("STAT_ATK")
	GlobalInfo.projectile_holder.add_child(proj)
	proj.global_position = global_position
	proj.initiate_projectile(direction)

	$SoundShoot.play()
