extends MoveController
class_name StraightLine

@export var speed: float = 10
var target
var direction


func _ready() -> void:
	target = GlobalInfo.player
	var pos = target.global_position + Vector2(randi_range(-200,200), randi_range(-200,200))
	direction = (pos - global_position).normalized()


func get_velocity() -> Vector2:
	return direction * speed
