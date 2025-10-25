extends Node2D
class_name ProjectileHolder


func _ready() -> void:
	GlobalInfo.projectile_holder = self
	#z_index = 1
