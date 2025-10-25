extends Resource
class_name BaseStat

signal value_changed(value: Variant)

@export var name = "Stat"
@export var icon: CompressedTexture2D
var value: Variant:
	get:
		return value

	set(val):
		value = val
		value_changed.emit(value)


func set_stat(_value: Variant) -> void:
	value = _value


func get_stat() -> Variant:
	return value


func init() -> void:
	pass
