extends MoveController
class_name WalkingBushMoveCantroler

@export var speed: float = 10
@export var ideal_radius: float = 300
@export var allowed_radius_deviation = 100

@export var debug_view: bool
var target: Player


func _ready() -> void:
	target = GlobalInfo.get_player()


func get_velocity() -> Vector2:

	queue_redraw()
	var velo = (target.position- global_position).normalized() * speed

	var dist = target.position.distance_to(global_position)
	var dist_diff = dist - ideal_radius

	if (absf(dist_diff) > allowed_radius_deviation):

		if dist_diff > 0:
			return velo
		else:
			return -velo

	return Vector2.ZERO


func _draw() -> void:
	if debug_view:
		draw_circle(Vector2.ZERO,ideal_radius - allowed_radius_deviation,Color.RED,false,5)
		draw_circle(Vector2.ZERO,ideal_radius + allowed_radius_deviation,Color.RED,false,5)
