extends GdUnitTestSuite


@onready var criterion_script: GDScript = preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_probability.gd")
var exp: Array[Vector2]


func assert_almost_eq_vector2_array(actual: Array[Vector2], expected: Array[Vector2], delta: float):
	assert_int(actual.size()).is_equal(expected.size())
	for i in range(actual.size()):
		assert_vector(actual[i]).is_equal_approx(expected[i], Vector2(delta, delta))


func test_point_append():
	var criterion: AssessCriterion = auto_free(criterion_script.new())

	assert_almost_eq_vector2_array(
		criterion.point_list,
		[Vector2(0.0, 0.0),Vector2(10.0, 1.0)],
		0.01)

	criterion.do_point_append()

	assert_almost_eq_vector2_array(
		criterion.point_list,
		[Vector2(0.0, 0.0),Vector2(10.0, 0.5),Vector2(20.0, 1.0)],
		0.01)

	criterion.do_point_append()

	assert_almost_eq_vector2_array(
		criterion.point_list,
		[Vector2(0.0, 0.0),Vector2(10.0, 0.33),Vector2(20.0, 0.66),Vector2(30.0, 1.0)],
		0.01)

	criterion.do_point_append()

	assert_almost_eq_vector2_array(
		criterion.point_list,
		[Vector2(0.0, 0.0),Vector2(10.0, 0.25),Vector2(20.0, 0.50),Vector2(30.0, 0.75),Vector2(40.0, 1.0)],
		0.01)

	criterion.do_point_append()

	assert_almost_eq_vector2_array(
		criterion.point_list,
		[Vector2(0.0, 0.0),Vector2(10.0, 0.2),Vector2(20.0, 0.4),Vector2(30.0, 0.6),Vector2(40.0, 0.8),Vector2(50.0, 1.0)],
		0.01)
