extends MoveController
class_name StraightLine

@export var speed: float = 10
var target
var direction


func _ready() -> void:
	target = GlobalInfo.player
	var pos = target.global_position + Vector2(randi_range(-200,200), randi_range(-200,200))
	direction = (pos - global_position).normalized()


func _process(delta: float) -> void:
	pass


func get_velocity() -> Vector2:
	return direction * speed


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area is AreaBounds:
		var pos = target.global_position + Vector2(randi_range(-200,200), randi_range(-200,200))
		direction = (pos - global_position).normalized()
