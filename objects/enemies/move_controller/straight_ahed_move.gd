
extends MoveController
class_name StraightAhed

@export var speed: float = 10
var target


func _ready() -> void:
	target = GlobalInfo.get_player()


func get_velocity() -> Vector2:
	return(target.position- global_position).normalized() * speed
