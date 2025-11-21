extends GdUnitTestSuite

@onready var criterion_script: GDScript = preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_value.gd")

var criterion: AssessCriterion


func assert_almost_eq_vector2_array(actual: Array[Vector2], expected: Array[Vector2], delta: float):
	assert_int(actual.size()).is_equal(expected.size())
	for i in range(actual.size()):
		assert_vector(actual[i]).is_equal_approx(expected[i], Vector2(delta, delta))


func before_test():
	criterion = criterion_script.new()
	criterion._ready()
	criterion.min_value = 0
	criterion.value_step = 10


func after_test():
	criterion.question.get_left().free()
	criterion.question.get_right().free()
	criterion.question.free()


func test_answer_p():
	criterion.step(AssessCriterion.Answer.p)
	assert_float(criterion.point_list[1].x).is_equal_approx(5.0, 0.01)


func test_answer_p_question():
	criterion.step(AssessCriterion.Answer.p)

	assert_float(criterion.question.get_left().win_value).is_equal(5.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(20.0)
	assert_float(criterion.question.get_right().win_probability).is_equal(0.5)
	assert_float(criterion.question.get_right().loss_value).is_equal(0.0)


func test_answer_q():
	criterion.step(AssessCriterion.Answer.q)
	assert_float(criterion.point_list[1].x).is_equal_approx(15.0, 0.01)


func test_answer_q_question():
	criterion.step(AssessCriterion.Answer.q)

	assert_float(criterion.question.get_left().win_value).is_equal(15.0)
	assert_float(criterion.question.get_left().win_probability).is_equal(1.0)
	assert_float(criterion.question.get_left().loss_value).is_equal(-1.0)

	assert_float(criterion.question.get_right().win_value).is_equal(20.0)
	assert_float(criterion.question.get_right().win_probability).is_equal(0.5)
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
	criterion.step(AssessCriterion.Answer.q) #15
	assert_float(criterion.point_list[-2].x).is_equal_approx(15.0, 0.01)

	criterion.step(AssessCriterion.Answer.q) #17.5
	assert_float(criterion.point_list[-2].x).is_equal_approx(17.5, 0.01)

	criterion.step(AssessCriterion.Answer.i)
	print(criterion.point_list) #skalowanie : 3
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.166, 0.01) #1/6
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.333, 0.01) #1/3

	criterion.step(AssessCriterion.Answer.p) # 18.75
	assert_float(criterion.point_list[-2].x).is_equal_approx(18.75, 0.01)

	criterion.step(AssessCriterion.Answer.p) # 18.125
	assert_float(criterion.point_list[-2].x).is_equal_approx(18.125, 0.01)
	print(criterion.point_list)
	criterion.step(AssessCriterion.Answer.i) #skalowanie : 1.5614
	print(criterion.point_list)
	assert_float(criterion.point_list[-3].y).is_equal_approx(0.213, 0.01) # 1/3 / 1.5614
	assert_float(criterion.point_list[-2].y).is_equal_approx(0.640, 0.01) # 1/1.5614
