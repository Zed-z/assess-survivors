extends Object
class_name Vector2Decimal

var x: Decimal
var y: Decimal


func _init(_x: Decimal, _y: Decimal) -> void:
	x = _x
	y = _y


func copy() -> Vector2Decimal:
	return Vector2Decimal.new(x.copy(), y.copy())


func equals(v2: Vector2Decimal) -> bool:
	return x.equals(v2.x) and y.equals(v2.y)


func _to_string() -> String:
	return "Vector2Decimal(%s, %s)" % [x, y]


func to_vector2() -> Vector2:
	return Vector2(x.get_float(), y.get_float())


func to_vector2i() -> Vector2i:
	return Vector2i(x.get_int(), y.get_int())
