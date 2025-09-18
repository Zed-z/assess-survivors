extends Object
class_name Decimal

var value_top: int = 0
var value_bottom: int = 1


func copy() -> Decimal:
	var d := Decimal.new()
	d.value_top = value_top
	d.value_bottom = value_bottom
	return d


func set_decimal(_value_top: int, _value_bottom: int) -> Decimal:
	value_top = _value_top
	value_bottom = _value_bottom

	normalize()
	return self


func set_int(_int: int) -> Decimal:
	value_top = _int
	value_bottom = 1

	normalize()
	return self


func set_float(_float: float, precision: int = 6) -> Decimal:
	var text = "%.*f" % [precision, _float]
	var decimal_places: int = 0

	if "." in text:
		decimal_places = text.split(".")[1].length()

	value_bottom = 10 ** decimal_places
	value_top = round(_float * decimal_places)

	normalize()
	return self


func normalize() -> Decimal:
	if value_top % value_bottom == 0:
		value_top /= value_bottom

	if value_bottom % value_top == 0:
		value_bottom /= value_top

	return self


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


func add(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	value_top *= _a.value_bottom
	value_bottom *= _a.value_bottom
	_a.value_top *= value_bottom
	_a.value_bottom *= value_bottom

	value_top += _a.value_top

	normalize()

	return self


func subtract(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	value_top *= _a.value_bottom
	value_bottom *= _a.value_bottom
	_a.value_top *= value_bottom
	_a.value_bottom *= value_bottom

	value_top -= _a.value_top

	normalize()

	return self


func equals(_a: Decimal) -> bool:
	var _a_copy: Decimal = _a.copy()

	normalize()
	_a.normalize()

	return value_top == _a.value_top and value_bottom == _a.value_bottom


func get_int() -> int:
	@warning_ignore("integer_division")
	return floor(value_top / value_bottom)


func get_float() -> float:
	return float(value_top) / float(value_bottom)
