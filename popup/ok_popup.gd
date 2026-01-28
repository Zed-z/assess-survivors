@tool
extends BasePopup
class_name OkPopup

@export var string_ok: String = "OK":
	set(val):
		string_ok = val
		if %ButtonOk:
			%ButtonOk.text = string_ok


func _ready() -> void:
	super._ready()

	string_ok = string_ok

	%ButtonOk.pressed.connect(ok)


func ok():
	closed.emit(PopupReturnValue.new(PopupReturnValue.Type.Ok))
	queue_free()


static func instantiate(parent: Control = null) -> OkPopup:
	var popup: OkPopup = preload("uid://bvetnmyda45mm").instantiate()

	if parent: parent.add_child(popup)
	return popup
