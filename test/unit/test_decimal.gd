extends GdUnitTestSuite


func test_get_value():

	var d1 := Decimal.new(1, 3)
	assert_float(d1.get_float()).is_equal_approx(0.33, 0.01)

	var d2 := Decimal.new(1, 2)
	assert_float(d2.get_float()).is_equal_approx(0.5, 0.01)


func test_normalize():
	var d = Decimal.new(4,2)
	assert_bool(d.normalize().equals(Decimal.new(2,1))).is_true()


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


func test_gcd_12_3():
	var d1: Decimal = Decimal.new(1,2)
	assert_int(d1._gcd(12,3)).is_equal(3)


func test_gcd_3_4():
	var d1: Decimal = Decimal.new(1,2)
	assert_int(d1._gcd(3,4)).is_equal(1)


func test_gcd_100_0():
	var d1: Decimal = Decimal.new(1,2)
	assert_int(d1._gcd(100,0)).is_equal(100)


func test_added_is_copy():
	var d1 := Decimal.new(1)
	var d2 := d1.added(Decimal.new(1))

	assert_int(d1.get_int()).is_equal(1)
	assert_int(d2.get_int()).is_equal(2)
