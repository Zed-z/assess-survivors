@tool
extends Control
class_name ChartVisualizerNode


@export var pos: Vector2 = Vector2(-1, -1)


func _ready() -> void:
	_on_mouse_exited()


func _on_mouse_entered() -> void:
	$Label.text = str(pos)
	$Label.visible = true

	$Panel.self_modulate = Color(20.0, 20.0, 20.0)


func _on_mouse_exited() -> void:
	$Label.visible = false

	$Panel.self_modulate = Color(1.0, 1.0, 1.0)
