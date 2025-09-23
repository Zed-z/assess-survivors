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

	assert_float(criterion.question[0].win_value).is_equal(10.0)
	assert_float(criterion.question[0].win_probability).is_equal(1.0)
	assert_float(criterion.question[0].loss_value).is_equal(-1.0)

	assert_float(criterion.question[1].win_value).is_equal(20.0)
	assert_float(criterion.question[1].win_probability).is_equal(0.5)
	assert_float(criterion.question[1].loss_value).is_equal(0.0)


func after_test():
	criterion.question[0].free()
	criterion.question[1].free()
	criterion.free()


func test_answer_p():
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.25, 0.01)


func test_answer_p_question():

	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.question[0].win_value).is_equal(10.0)
	assert_float(criterion.question[0].win_probability).is_equal(1.0)
	assert_float(criterion.question[0].loss_value).is_equal(-1.0)

	assert_float(criterion.question[1].win_value).is_equal(20.0)
	assert_float(criterion.question[1].win_probability).is_equal(0.75)
	assert_float(criterion.question[1].loss_value).is_equal(0.0)


func test_answer_q():
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.75, 0.01)


func test_answer_q_question():
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[1].y).is_equal_approx(0.75, 0.01)

	assert_float(criterion.question[0].win_value).is_equal(10.0)
	assert_float(criterion.question[0].win_probability).is_equal(1.0)
	assert_float(criterion.question[0].loss_value).is_equal(-1.0)

	assert_float(criterion.question[1].win_value).is_equal(20.0)
	assert_float(criterion.question[1].win_probability).is_equal(0.25)
	assert_float(criterion.question[1].loss_value).is_equal(0.0)


func test_answer_i():
	criterion.step(AssessCriterion.Answer.i)
	assert_almost_eq_vector2_array(criterion.point_list, [Vector2(0, 0), Vector2(10, 0.333),Vector2(20, 0.666),Vector2(30, 1)], 0.01)


func test_answer_i_question():
	criterion.step(AssessCriterion.Answer.i)

	assert_float(criterion.question[0].win_value).is_equal(20.0)
	assert_float(criterion.question[0].win_probability).is_equal(1.0)
	assert_float(criterion.question[0].loss_value).is_equal(-1.0)

	assert_float(criterion.question[1].win_value).is_equal(30.0)
	assert_float(criterion.question[1].win_probability).is_equal_approx(0.33, 0.01)
	assert_float(criterion.question[1].loss_value).is_equal(0.0)


func test_scenario_1():
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.q)
	criterion.step(AssessCriterion.Answer.i)
	criterion.step(AssessCriterion.Answer.p)
	criterion.step(AssessCriterion.Answer.p)
	assert_almost_eq_vector2_array(criterion.point_list, [
	Vector2(0, 0.0),
	Vector2(10, 0.07756449505437976),
	Vector2(20, 0.17452011387235447),
	Vector2(30, 0.37651098640980174),
	Vector2(40, 0.40680961729041887),
	Vector2(50, 0.7779678455779783),
	Vector2(60, 0.7912234965882482),
	Vector2(70, 0.9536052214640551),
	Vector2(80, 0.9594045687810482),
	Vector2(90, 1.0)], 0.1)


func test_scenario_2():
	criterion.step(AssessCriterion.Answer.q) #3/4
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.75, 0.01)

	criterion.step(AssessCriterion.Answer.q) #7/8
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.875, 0.01)

	criterion.step(AssessCriterion.Answer.i) #skalowanie : 9/8
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.777, 0.01) #7/9
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.888, 0.01) # 8/9

	criterion.step(AssessCriterion.Answer.p) # 15/18
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.833, 0.01)

	criterion.step(AssessCriterion.Answer.p) # 29/36
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.805, 0.01)

	criterion.step(AssessCriterion.Answer.i) #skalowanie 43/36
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.674, 0.01) # 29/43
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.837, 0.01) # 36/43
