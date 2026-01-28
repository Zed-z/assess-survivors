extends GdUnitTestSuite

#calc is short for calculator


func assert_almost_eq_array(actual: Array[float], expected: Array[float], delta: float):
	assert_int(actual.size()).is_equal(expected.size())
	for i in range(actual.size()):
		assert_float(actual[i]).is_equal_approx(expected[i], delta)
		pass


func test_sum():
	var nums: Array[float] = [0.1, 0.2, 0.3, 0.4]
	assert_float(Polynomials_calculator.sum(nums)).is_equal_approx(1, 0.01)


func test_product():
	var nums: Array[float] = [1.0, 2.0, 3.0]
	assert_float(Polynomials_calculator.product(nums)).is_equal_approx(6.0, 0.01)


func test_generate_polynomial():
	assert_almost_eq_array(Polynomials_calculator.create_polynomial([0.5,0.5]), [0.25, 0, 0], 0.01)


func test_bairstow():
	assert_float(Polynomials_calculator.bairstow(Polynomials_calculator.create_polynomial([0.5,0.5]))[0]).is_equal(0.0)
	#assert_almost_eq_array(Polynomials_calculator.bairstow(Polynomials_calculator.create_polynomial([0.5,0.5])), [0.0], 0.01)


func test_partial_u():

	assert_float(Polynomials_calculator.calculate_partial_usefullness([Vector2(0.0, 1.0), Vector2(1.0,0.0)], 1.0)).is_equal_approx(0.0, 0.001)


func test_global_U():
	var first_one = AssessCriterion.new()
	first_one.min_value = 0.0
	first_one.initial_max_value = 1.0
	first_one.setup()
	var second_one = AssessCriterion.new()
	second_one.min_value = 1.0
	second_one.initial_max_value = 0.0
	second_one.setup()
	var variant: Dictionary[AssessCriterion, float] = {first_one: 1.0, second_one: 0.0}
	var K = 0.0
	assert_float(Polynomials_calculator.calculate_global_usefullness(K, variant)).is_equal_approx(1.0, 0.001)


func test_global_U_2():
	var first_one = AssessCriterion.new()
	first_one.set_values([Vector2(40.0, 0.0),Vector2(20.0, 0.8), Vector2(0, 1.0)], 0.75)
	var second_one = AssessCriterion.new()
	second_one.set_values([Vector2(0.0, 0.0),Vector2(20.0, 0.4),Vector2(40.0, 0.8), Vector2(50, 1.0)], 0.25)
	var K = -2/0.375
	var variant: Dictionary[AssessCriterion, float] = {first_one: 0.0, second_one: 50.0}
