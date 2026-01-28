@tool
extends BasePopup
class_name YesNoPopup

@export var string_yes: String = "Yes":
	set(val):
		string_yes = val

		if %ButtonYes:
			%ButtonYes.text = string_yes
@export var string_no: String = "No":
	set(val):
		string_no = val

		if %ButtonNo:
			%ButtonNo.text = string_no


func _ready() -> void:
	super._ready()

	string_yes = string_yes
	string_no = string_no

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
