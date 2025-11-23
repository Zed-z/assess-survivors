extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("sway")
	$AnimationPlayer.advance(randf_range(0, $AnimationPlayer.current_animation_length))
