extends GdUnitTestSuite

@onready var criterion_script: GDScript = preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_probability.gd")

var criterion: AssessCriterion


func assert_almost_eq_vector2_array(actual: Array[Vector2], expected: Array[Vector2], delta: float):
	assert_int(actual.size()).is_equal(expected.size())
	for i in range(actual.size()):
		assert_vector(actual[i]).is_equal_approx(expected[i], Vector2(delta, delta))


func before_test():
	criterion = criterion_script.new()
	criterion._ready()
	criterion.MIN_value = 0
	criterion.value_step = 10

	assert_float(criterion.question.get_left().win_value).is_equal(10.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(20.0)
	assert_float(criterion.question.get_right().win_probability).is_equal(0.5)
	assert_float(criterion.question.get_right().loss_value).is_equal(0.0)


func after_test():
	criterion.question.get_left().free()
	criterion.question.get_right().free()
	criterion.question.free()
	criterion.free()


func test_answer_p():
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.75, 0.01)


func test_answer_p_question():

	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.question.get_left().win_value).is_equal(10.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(20.0)
	assert_float(criterion.question.get_right().win_probability).is_equal(0.75)
	assert_float(criterion.question.get_right().loss_value).is_equal(0.0)


func test_answer_q():
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.25, 0.01)


func test_answer_q_question():
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.25, 0.01)

	assert_float(criterion.question.get_left().win_value).is_equal(10.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(20.0)
	assert_float(criterion.question.get_right().win_probability).is_equal(0.25)
	assert_float(criterion.question.get_right().loss_value).is_equal(0.0)


func test_answer_i():
	criterion.step(AssessCriterion.Answer.i)
	assert_almost_eq_vector2_array(criterion.point_list, [Vector2(0, 0), Vector2(10, 0.333),Vector2(20, 0.666),Vector2(30, 1)], 0.01)


func test_answer_i_question():
	criterion.step(AssessCriterion.Answer.i)

	assert_float(criterion.question.get_left().win_value).is_equal(20.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(30.0)
	assert_float(criterion.question.get_right().win_probability).is_equal_approx(0.66, 0.01)
	assert_float(criterion.question.get_right().loss_value).is_equal(0.0)


func test_scenario_1():
	criterion.step(AssessCriterion.Answer.p) #3/4
	criterion.step(AssessCriterion.Answer.q) # 5/8

	assert_float(criterion.point_list[-2].y).is_equal_approx(0.625, 0.01)
	criterion.step(AssessCriterion.Answer.i) #przeskalowanie 11/8
	criterion.step(AssessCriterion.Answer.p) # 19/22
	assert_float(criterion.point_list[-2].y).is_equal_approx(19.0/22, 0.01)
	criterion.step(AssessCriterion.Answer.q) #35/44
	assert_float(criterion.point_list[-2].y).is_equal_approx(35.0/44, 0.01)
	criterion.step(AssessCriterion.Answer.i) #przeskalowanie 53/44
	criterion.step(AssessCriterion.Answer.q) # 78/106
	assert_float(criterion.point_list[-2].y).is_equal_approx(78/106.0, 0.01)
	criterion.step(AssessCriterion.Answer.p) # 83/106
	assert_float(criterion.point_list[-2].y).is_equal_approx(83/106.0, 0.01)
	criterion.step(AssessCriterion.Answer.i) # przeskalowanie 129/106
	assert_float(criterion.point_list[-2].y).is_equal_approx(106.0/129, 0.01)
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[-2].y).is_equal_approx(235/258.0, 0.01)
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[-2].y).is_equal_approx(493/516.0, 0.01)
	criterion.step(AssessCriterion.Answer.i) # przeskalowanie 539/516
	assert_float(criterion.point_list[-2].y).is_equal_approx(516/539.0, 0.01)
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[-2].y).is_equal_approx(1009.0/1078, 0.01)
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[-2].y).is_equal_approx(1995.0/2156, 0.01)
	criterion.step(AssessCriterion.Answer.i) # przeskalowanie 2317/2156
	assert_float(criterion.point_list[-2].y).is_equal_approx(2156.0/2317, 0.01)
	criterion.step(AssessCriterion.Answer.p) #
	assert_float(criterion.point_list[-2].y).is_equal_approx(4473.0/4634, 0.001)
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[-2].y).is_equal_approx(9107.0/9268, 0.001)
	criterion.step(AssessCriterion.Answer.i) #przeskalowanie 9429/9268
	assert_float(criterion.point_list[-2].y).is_equal_approx(9268.0/9429, 0.001)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.p)
	#assert_almost_eq_vector2_array(criterion.point_list, [
	#Vector2(0, 0.0),
	#Vector2(10, 0.07756449505437976),
	#Vector2(20, 0.17452011387235447),
	#Vector2(30, 0.37651098640980174),
	#Vector2(40, 0.40680961729041887),
	#Vector2(50, 0.7779678455779783),
	#Vector2(60, 0.7912234965882482),
	#Vector2(70, 0.9536052214640551),
	#Vector2(80, 0.9594045687810482),
	#Vector2(90, 1.0)], 0.1)


func test_scenario_2():
	criterion.step(AssessCriterion.Answer.q) # 1/4
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.25, 0.01)

	criterion.step(AssessCriterion.Answer.q) # 1/8
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.125, 0.01)

	criterion.step(AssessCriterion.Answer.i) #skalowanie : 15/8
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.066, 0.001) #1/15
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.533, 0.001) # 8/15

	criterion.step(AssessCriterion.Answer.p) # 23/30
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.7666, 0.001)

	criterion.step(AssessCriterion.Answer.p) # 53/60
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.883, 0.001)

	criterion.step(AssessCriterion.Answer.i) #skalowanie 67/60
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.791, 0.01) # 53/67
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.895, 0.01) # 60/67
