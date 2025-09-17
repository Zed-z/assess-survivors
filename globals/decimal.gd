extends Object
class_name Decimal

var value_top: int = 0
var value_bottom: int = 1

func set_int(_int: int) -> void:
	value_top = _int
	value_bottom = 1

func set_float(_float: float) -> void:
	var s := str(_float)

	value_top = _float
	value_bottom = 1

func normalize():
	if value_top % value_bottom == 0:
		value_top /= value_bottom

	if value_bottom % value_top == 0:
		value_bottom /= value_top

func multiply(_a: Decimal) -> Decimal:
	value_top *= _a.value_top
	value_bottom *= _a.value_bottom
	normalize()
	return self

func divide(_a: Decimal) -> Decimal:
	value_top *= _a.value_bottom
	value_bottom *= _a.value_top
	normalize()
	return self

func equals(_a: Decimal) -> bool:
	var _a_copy: Decimal = _a.copy()

	normalize()
	_a.normalize()

	return value_top == _a.value_top and value_bottom == _a.value_bottom

func get_int() -> int:
	return value_top / value_bottom

func get_float() -> float:
	return float(value_top) / float(value_bottom)
