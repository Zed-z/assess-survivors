@tool
extends BasePopup
class_name TextInputPopup

@export var allow_empty: bool = false


func _ready() -> void:
	super._ready()

	%ButtonOk.pressed.connect(ok)


func ok():
	if allow_empty or %Input.text.length() > 0:
		closed.emit(PopupReturnValue.new(PopupReturnValue.Type.TextInput, %Input.text))
		queue_free()


static func instantiate(parent: Control = null) -> TextInputPopup:
	var popup: TextInputPopup = preload("uid://spkrq1jvi4r6").instantiate()

	if parent: parent.add_child(popup)
	return popup
