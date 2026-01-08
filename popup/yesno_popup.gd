@tool
extends BasePopup
class_name YesNoPopup


func _ready() -> void:
	super._ready()

	%ButtonYes.pressed.connect(yes)
	%ButtonNo.pressed.connect(no)


func yes():
	closed.emit(PopupReturnValue.new(PopupReturnValue.Type.YesNo, true))
	queue_free()


func no():
	closed.emit(PopupReturnValue.new(PopupReturnValue.Type.YesNo, false))
	queue_free()


static func instantiate(parent: Control = null) -> YesNoPopup:
	var popup: YesNoPopup = preload("uid://bb2rnkf7uc1gc").instantiate()

	if parent: parent.add_child(popup)
	return popup
