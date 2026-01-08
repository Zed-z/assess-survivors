@tool
extends Control
class_name BasePopup

signal closed(return_value: PopupReturnValue)

@export var can_be_closed: bool = true:
	set(val):
		can_be_closed = val

		if %ButtonClose:
			%ButtonClose.visible = can_be_closed
@export var pause_tree: bool = true
@export var title: String = "Popup":
	set(val):
		title = val

		if %Title:
			%Title.text = title
@export_multiline var text: String = "":
	set(val):
		text = val

		if %Text:
			%Text.text = text


func _ready() -> void:

	# Run setters
	title = title
	text = text
	can_be_closed = can_be_closed

	%ButtonClose.pressed.connect(close)

	%TitleBar.mouse_entered.connect(titlebar_mouse_entered)
	%TitleBar.mouse_exited.connect(titlebar_mouse_exited)

	if pause_tree:
		if not Engine.is_editor_hint():
			get_tree().paused = true

var titlebar_mouse_hovering: bool = false
var titlebar_mouse_offset: Vector2 = Vector2.ZERO
var titlebar_mouse_dragging: bool = false


func titlebar_mouse_entered():
	titlebar_mouse_hovering = true


func titlebar_mouse_exited():
	titlebar_mouse_hovering = false


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if titlebar_mouse_hovering:
				titlebar_mouse_offset = get_viewport().get_mouse_position() - self.global_position
				titlebar_mouse_dragging = true

		if event.is_released():
			titlebar_mouse_offset = Vector2.ZERO
			titlebar_mouse_dragging = false


func _exit_tree() -> void:
	if pause_tree:
		if not Engine.is_editor_hint():
			get_tree().paused = false


func close():
	closed.emit(PopupReturnValue.new(PopupReturnValue.Type.Close))
	queue_free()


func _process(delta: float) -> void:
	if titlebar_mouse_dragging:
		var pos: Vector2 = get_viewport().get_mouse_position() - titlebar_mouse_offset
		self.global_position = pos

		var parent: Control = get_parent()
		self.global_position.x = clamp(
			self.global_position.x,
			parent.global_position.x,
			parent.global_position.x + parent.size.x - self.size.x)

		self.global_position.y = clamp(
			self.global_position.y,
			parent.global_position.y,
			parent.global_position.y + parent.size.y - self.size.y)


static func instantiate(parent: Control = null) -> BasePopup:
	var popup: BasePopup = preload("uid://cg068o0hw2swp").instantiate()

	if parent: parent.add_child(popup)
	return popup
