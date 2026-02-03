extends PlayerAction
class_name PlayerActionProjectileShooter

@export var projectile: PackedScene
@export var projectile_speed: float = 200


func get_cooldown():
	return Utils.map_cooldown(player.stats.get_stat("STAT_COOLDOWN"))


func execute_action():
	var aim_direction: Vector2 = (get_global_mouse_position() - global_position)
	var direction: Vector2 = aim_direction.normalized() * projectile_speed

	var proj: ProjectilePlayer = projectile.instantiate() as ProjectilePlayer
	proj.pierce_left = player.stats.get_stat("STAT_PIERCE")
	proj.damage = player.stats.get_stat("STAT_ATK")
	GlobalInfo.projectile_holder.add_child(proj)
	proj.global_position = global_position
	proj.initiate_projectile(direction)

	$SoundShoot.play()
