extends Control
class_name ChartVisualizerNode


@export var pos: Vector2


func _on_mouse_entered() -> void:
	$Label.text = str(pos)
	$Label.visible = true


func _on_mouse_exited() -> void:
	$Label.visible = false
