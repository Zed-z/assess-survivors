extends GdUnitTestSuite


func test_get_value():

	var d1 := Decimal.new(1, 3)
	assert_float(d1.get_float()).is_equal_approx(0.33, 0.01)

	var d2 := Decimal.new(1, 2)
	assert_float(d2.get_float()).is_equal_approx(0.5, 0.01)


func test_normalize_negative():

	var d1 := Decimal.new(-2, 20)
	assert_bool(d1.normalize().equals(Decimal.new(-1, 10)))


func test_add():

	var d1 := Decimal.new(1, 10)
	var d2 := Decimal.new(2, 10)

	assert_bool(d1.add(d2).equals(Decimal.new(3, 10)))


func test_subtract():

	var d1 := Decimal.new(2, 10)
	var d2 := Decimal.new(1, 10)

	assert_bool(d1.subtract(d2).equals(Decimal.new(1, 10)))


func test_subtract_negative():

	var d1 := Decimal.new(1, 10)
	var d2 := Decimal.new(2, 10)

	assert_bool(d1.subtract(d2).equals(Decimal.new(-1, 10)))


func test_multiply_1():

	var d1 := Decimal.new(3, 4)
	var d2 := Decimal.new(4, 3)

	assert_bool(d1.multiply(d2).equals(Decimal.new(1, 1)))


func test_multiply_2():

	var d1 := Decimal.new(3, 4)
	var d2 := Decimal.new(1, 3)

	assert_bool(d1.multiply(d2).equals(Decimal.new(1, 4)))


func test_divide_1():

	var d1 := Decimal.new(3, 4)
	var d2 := Decimal.new(1, 3)

	assert_bool(d1.divide(d2).equals(Decimal.new(9, 4)))
