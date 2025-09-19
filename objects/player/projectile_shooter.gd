extends Node2D

@export var projectile: PackedScene


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var direction: Vector2 = get_global_mouse_position() - global_position
			shoot_projectile(direction)


func shoot_projectile(direction: Vector2):
	var proj: BaseProjectile = projectile.instantiate() as BaseProjectile
	ProjectileHolder.add_child(proj)
	proj.global_position = global_position
	proj.initiate_projectile(direction)
