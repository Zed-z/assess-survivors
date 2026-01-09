@tool
extends BasePopup
class_name OkPopup


func _ready() -> void:
	super._ready()

	%ButtonOk.pressed.connect(ok)


func ok():
	closed.emit(PopupReturnValue.new(PopupReturnValue.Type.Ok))
	queue_free()


static func instantiate(parent: Control = null) -> OkPopup:
	var popup: OkPopup = preload("uid://bvetnmyda45mm").instantiate()

	if parent: parent.add_child(popup)
	return popup
