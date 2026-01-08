extends RefCounted
class_name PopupReturnValue

enum Type {
	Close,
	Ok,
	YesNo
}

var type: Type
var data: Variant


func _init(_type: Type, _data: Variant = null) -> void:
	type = _type
	data = _data
