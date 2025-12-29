extends MoveController
class_name RangerMoveControler

@export var speed: float = 10
@export var escape_radius: float = 450
@export var debug_view: bool = false
var target: Player


func _ready() -> void:
	target = GlobalInfo.player


func get_velocity() -> Vector2:

	queue_redraw()
	var velo = (target.position- global_position).normalized() * 10

	if target.position.distance_squared_to(global_position) > pow(escape_radius,2):
		return velo

	return -velo


func _draw() -> void:
	if debug_view:
		draw_circle(Vector2.ZERO,escape_radius,Color.RED,false,5)
