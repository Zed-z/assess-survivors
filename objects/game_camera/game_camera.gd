extends Node2D
class_name GameCamera

var parent: Node2D

@export_range(0, 1, 0.001) var lerp_speed: float = 0.125


func _ready() -> void:
	parent = get_parent()
	GlobalInfo.game_camera = self


func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(parent.global_position, lerp_speed)


func shake():
	if SettingsManager.get_setting("video/screen_shake"):
		$AnimationPlayer.play("shake")
