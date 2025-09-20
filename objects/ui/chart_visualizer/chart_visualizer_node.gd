@tool
extends Control
class_name ChartVisualizerNode

var pos: Vector2


func _ready() -> void:
	_on_mouse_exited()


func _on_mouse_entered() -> void:
	$Label.text = "%s: %s%%" % [snapped(pos.x, 0.01), snapped(pos.y * 100, 0.01)]
	$Label.visible = true

	$Panel.self_modulate = Color(20.0, 20.0, 20.0)


func _on_mouse_exited() -> void:
	$Label.visible = false

	$Panel.self_modulate = Color(1.0, 1.0, 1.0)
