extends Node2D


func _ready() -> void:
	if int(global_position.x / 2) % 2 == 0:
		$Sprite2D.queue_free()
	else:
		$Sprite2D2.queue_free()
