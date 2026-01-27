extends RefCounted
class_name DamageParameters

var damage: float = 1
var direction: Vector2


func _init(dmg:float, dir: Vector2 = Vector2(0,0)) -> void:
	damage = dmg
	direction = dir
