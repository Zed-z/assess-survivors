extends Object
class_name Decimal

var numerator: int = 0
var denominator: int = 1


func copy() -> Decimal:
	var d := Decimal.new(numerator, denominator)
	return d


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
	if numerator % denominator == 0:
		numerator /= denominator

	if denominator % numerator == 0:
		denominator /= numerator

	return self


func multiply(_a: Decimal) -> Decimal:
	numerator *= _a.numerator
	denominator *= _a.denominator
	normalize()
	return self


func divide(_a: Decimal) -> Decimal:
	numerator *= _a.denominator
	denominator *= _a.numerator
	normalize()
	return self


func add(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	numerator *= _a.denominator
	denominator *= _a.denominator
	_a.numerator *= denominator
	_a.denominator *= denominator

	numerator += _a.numerator

	normalize()

	return self


func subtract(_a: Decimal) -> Decimal:
	var _a_copy: Decimal = _a.copy()

	numerator *= _a.denominator
	denominator *= _a.denominator
	_a.numerator *= denominator
	_a.denominator *= denominator

	numerator -= _a.numerator

	normalize()

	return self


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
