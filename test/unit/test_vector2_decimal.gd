extends GdUnitTestSuite


func test_values():
	var v1 := Vector2Decimal.new(Decimal.new(1), Decimal.new(2))

	assert_bool(v1.x.get_int() == 1 and v1.y.get_int() == 2).is_true()


func test_copy():
	var v1 := Vector2Decimal.new(Decimal.new(1), Decimal.new(2))
	var v2 := v1.copy()

	assert_bool(v1.equals(v2))
