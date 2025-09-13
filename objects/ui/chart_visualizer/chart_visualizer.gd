@tool
extends Control

@export var xaxis: Vector2 = Vector2(0, 10):
	set(val):
		xaxis = val
		set_points()

@export var xaxis_base: float = 0:
	set(val):
		xaxis_base = val
		set_points()

@export var yaxis: Vector2 = Vector2(0, 30):
	set(val):
		yaxis = val
		set_points()

@export var yaxis_base: float = 10:
	set(val):
		yaxis_base = val
		set_points()

@export var points: Array[Vector2]:
	set(val):
		points = val
		set_points()

@export_tool_button("Set Points", "Callable")
var action: Callable = set_points

func translate_x(x: float) -> float:
	return lerp(0.0, size.x, inverse_lerp(xaxis.x, xaxis.y, x))

func translate_y(y: float) -> float:
	return lerp(size.y, 0.0, inverse_lerp(yaxis.x, yaxis.y, y))

func set_points():

	$YaxisBase.clear_points()
	var y_: float = translate_y(yaxis_base)
	$YaxisBase.add_point(Vector2(0, y_))
	$YaxisBase.add_point(Vector2(size.x, y_))

	$XaxisBase.clear_points()
	var x_: float = translate_x(xaxis_base)
	$XaxisBase.add_point(Vector2(x_, 0))
	$XaxisBase.add_point(Vector2(x_, size.y))

	$Line2D.clear_points()

	var arr = PackedVector2Array()
	arr.append(Vector2(0, size.y))

	for point: Vector2 in points:
		var x: float = translate_x(point.x)
		var y: float = translate_y(point.y)

		$Line2D.add_point(Vector2(x_ + x, yaxis_base + y))
		arr.append(Vector2(x_ + x, yaxis_base + y))

	arr.append(Vector2(size.x, size.y))
	$Polygon2D.polygon = arr


func _on_resized() -> void:
	set_points()
