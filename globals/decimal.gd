extends Object
class_name Decimal

var numerator: int = 0
var denominator: int = 1


func copy() -> Decimal:
	return Decimal.new(numerator, denominator)


func _init(_numerator: int, _denominator: int = 1) -> void:
	numerator = _numerator
	denominator = _denominator
	normalize()


func set_float(_float: float, precision: int = 6) -> Decimal:
	var text = "%.*f" % [precision, _float]
	var decimal_places: int = 0

	if "." in text:
		decimal_places = text.split(".")[1].length()

	denominator = 10 ** decimal_places
	numerator = round(_float * decimal_places)

	normalize()
	return self


func normalize() -> Decimal:
	var minus: bool = (numerator >= 0) != (denominator >= 0)

	numerator = abs(numerator)
	denominator = abs(denominator)

	var divisor: int = _gcd(numerator,denominator)

	numerator /= divisor
	denominator /= divisor

	if (minus):
		numerator *= -1

	return self


func multiply(_a: Decimal) -> Decimal:
	numerator *= _a.numerator
	denominator *= _a.denominator
	normalize()
	return self


func multiplied(_a: Decimal) -> Decimal:
	return copy().multiply(_a)


func divide(_a: Decimal) -> Decimal:
	numerator *= _a.denominator
	denominator *= _a.numerator
	normalize()
	return self


func divided(_a: Decimal) -> Decimal:
	return copy().divide(_a)


func add(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	var self_denominator := denominator
	var other_denominator := _a_copy.denominator

	numerator *= other_denominator
	denominator *= other_denominator
	_a_copy.numerator *= self_denominator
	_a_copy.denominator *= self_denominator

	numerator += _a_copy.numerator

	normalize()

	return self


func added(_a: Decimal) -> Decimal:
	return copy().add(_a)


func subtract(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	var self_denominator := denominator
	var other_denominator := _a_copy.denominator

	numerator *= other_denominator
	denominator *= other_denominator
	_a_copy.numerator *= self_denominator
	_a_copy.denominator *= self_denominator

	numerator -= _a_copy.numerator

	normalize()

	return self


func subtracted(_a: Decimal) -> Decimal:
	return copy().subtract(_a)


func equals(_a: Decimal) -> bool:
	var _a_copy: Decimal = _a.copy()

	normalize()
	_a.normalize()

	return numerator == _a.numerator and denominator == _a.denominator


func get_int() -> int:
	@warning_ignore("integer_division")
	return floor(numerator / denominator)


func get_float() -> float:
	return float(numerator) / float(denominator)


func _gcd(a: int, b: int) -> int:
	while (a != 0 and b != 0):
		if (a > b):
			a %= b
		else:
			b %= a

	if (a == 0):
		return b
	else:
		return a


func _to_string() -> String:
	if denominator == 1:
		return str(numerator)

	return "%s/%s" % [numerator, denominator]
