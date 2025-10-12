extends Resource
class_name BaseStat

@export var name = "Stat"
var value: Variant


func set_stat(_value: Variant) -> void:
	value = _value


func get_stat() -> Variant:
	return value


func init() -> void:
	pass
