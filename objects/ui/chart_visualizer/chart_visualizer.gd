@tool
extends Control
class_name ChartVisualizer

var chart_node := preload("res://objects/ui/chart_visualizer/chart_visualizer_node.tscn")

@export_tool_button("Update", "Callable")
var action: Callable = update_chart

@export_category("Data")

@export var auto_xaxis: bool = false:
	set(val):
		auto_xaxis = val
		update_chart()

@export var xaxis: Vector2 = Vector2(0, 1):
	set(val):
		xaxis = val
		update_chart()

@export var xaxis_base: float = 0:
	set(val):
		xaxis_base = val
		update_chart()

@export var auto_yaxis: bool = false:
	set(val):
		auto_yaxis = val
		update_chart()

@export var yaxis: Vector2 = Vector2(0, 1):
	set(val):
		yaxis = val
		update_chart()

@export var yaxis_base: float = 0:
	set(val):
		yaxis_base = val
		update_chart()

@export var points: Array[Vector2] = [Vector2(0,0), Vector2(1,1)]:
	set(val):
		points = val
		update_chart()

@export_category("Colors")

@export var background_color: Color = Color.WHITE:
	set(val):
		background_color = val
		update_chart()

@export var line_color: Color = Color.RED:
	set(val):
		line_color = val
		update_chart()

@export var line_fill: bool = true:
	set(val):
		line_fill = val
		update_chart()

@export var axis_color: Color = Color.BLACK:
	set(val):
		axis_color = val
		update_chart()

@export var margin: int = 10:
	set(val):
		margin = val
		update_chart()

@export var axis_base_stickout: int = 5:
	set(val):
		axis_base_stickout = val
		update_chart()


func translate_x(x: float, _xaxis: Vector2 = xaxis) -> float:
	return lerp(0.0, %ChartArea.size.x, inverse_lerp(_xaxis.x, _xaxis.y, x))


func translate_y(y: float, _yaxis: Vector2 = yaxis) -> float:
	return lerp(%ChartArea.size.y, 0.0, inverse_lerp(_yaxis.x, _yaxis.y, y))


func set_points(_points: Array[Vector2]):
	points = _points


func update_chart():

	if not is_node_ready():
		return

	# Colors
	$Canvas.color = background_color
	%ChartArea.color = background_color
	%Line.default_color = line_color

	%CanvasMargin.add_theme_constant_override("margin_left", margin)
	%CanvasMargin.add_theme_constant_override("margin_top", margin)
	%CanvasMargin.add_theme_constant_override("margin_right", margin)
	%CanvasMargin.add_theme_constant_override("margin_bottom", margin)

	if line_fill:
		%Polygon.color = Color(line_color, 0.5)
	else:
		%Polygon.visible = false

	%XaxisBase.default_color = axis_color
	%YaxisBase.default_color = axis_color

	# Points
	if not is_node_ready():
		return

	var _xaxis := xaxis
	var _yaxis := yaxis

	if auto_xaxis:
		_xaxis.x = 0
		_xaxis.y = 0

		for point: Vector2 in points:
			_xaxis.x = min(_xaxis.x, point.x)
			_xaxis.y = max(_xaxis.y, point.x)

	if auto_yaxis:
		_yaxis.x = 0
		_yaxis.y = 0

		for point: Vector2 in points:
			_yaxis.x = min(_yaxis.x, point.y)
			_yaxis.y = max(_yaxis.y, point.y)

	%YaxisBase.clear_points()
	var y_: float = translate_y(yaxis_base, _yaxis)
	%YaxisBase.add_point(Vector2(0 - axis_base_stickout, y_))
	%YaxisBase.add_point(Vector2(%ChartArea.size.x + axis_base_stickout, y_))

	%XaxisBase.clear_points()
	var x_: float = translate_x(xaxis_base, _xaxis)
	%XaxisBase.add_point(Vector2(x_, 0 - axis_base_stickout))
	%XaxisBase.add_point(Vector2(x_, %ChartArea.size.y + axis_base_stickout))

	%Line.clear_points()
	for child: Node in %Line.get_children():
		child.queue_free()

	var arr = PackedVector2Array()
	arr.append(Vector2(0, %ChartArea.size.y))

	for point: Vector2 in points:
		var x: float = translate_x(point.x, _xaxis)
		var y: float = translate_y(point.y, _yaxis)
		var xy: Vector2 = Vector2(x_ + x, yaxis_base + y)

		%Line.add_point(xy)
		arr.append(xy)

		var n: ChartVisualizerNode = chart_node.instantiate()
		n.position = xy
		n.pos = point
		n.modulate = line_color
		%Line.add_child(n)

	arr.append(Vector2(%ChartArea.size.x, %ChartArea.size.y))
	%Polygon.polygon = arr


func _ready() -> void:
	update_chart()


func _on_resized() -> void:
	update_chart()
