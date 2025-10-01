extends Node2D

@export var projectile: PackedScene
@export var projectile_speed: float = 200

@onready var stats: PlayerStats = $"../Stats"


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var aim_direction: Vector2 = (get_global_mouse_position() - global_position)
			var direction: Vector2 = aim_direction.normalized() * projectile_speed

			shoot_projectile(direction)


func shoot_projectile(direction: Vector2):
	var proj: BaseProjectile = projectile.instantiate() as BaseProjectile
	proj.damage = stats.get_stat(PlayerStats.STATS.ATTACK)
	ProjectileHolder.add_child(proj)
	proj.global_position = global_position
	proj.initiate_projectile(direction)
