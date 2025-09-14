extends Node2D
class_name BaseProjectile

var direction : Vector2

func initiate_projectile(vec : Vector2) -> void:
	direction = vec


func _process(delta: float) -> void:
	position += direction * delta
