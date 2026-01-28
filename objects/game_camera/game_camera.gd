extends Node2D
class_name GameCamera

var parent: Node2D
var tween: Tween

@export_range(0, 1, 0.001) var lerp_speed: float = 0.125


func _ready() -> void:
	parent = get_parent()
	GlobalInfo.game_camera = self


func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(parent.global_position, lerp_speed)


func shake_scalable(p: Vector2 = Vector2(10,10), angle: float = 1):

	if not SettingsManager.get_setting("video/screen_shake"):
		return

	if tween:
		tween.kill()

	tween = get_tree().create_tween()
	var pos := tween.parallel()
	pos.tween_property($Camera2D,"position",-p,0.0666).from_current()
	pos.tween_property($Camera2D,"position",p,0.0666).from_current()
	pos.tween_property($Camera2D,"position",Vector2(0,0),0.0666).from_current()
	var rot = tween.parallel()
	rot.tween_property($Camera2D,"rotation",deg_to_rad(-angle),0.0666).from_current()
	rot.tween_property($Camera2D,"rotation",deg_to_rad(angle),0.0666).from_current()
	rot.tween_property($Camera2D,"rotation",0,0.0666).from_current()
