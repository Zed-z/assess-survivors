extends GutTest

@onready var criterion_script: GDScript = preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_probability.gd")
var exp: Array[Vector2]

func test_point_append():
	var criterion: AssessCriterion = criterion_script.new()

	assert_eq(criterion.point_list, [Vector2(0.0, 0.0),Vector2(10.0, 1.0)])

	criterion.do_point_append()

	assert_eq(criterion.point_list, [Vector2(0.0, 0.0),Vector2(10.0, 0.5),Vector2(20.0, 1.0)])

	criterion.do_point_append()

	exp = [Vector2(0.0, 0.0),Vector2(10.0, 0.33),Vector2(20.0, 0.66),Vector2(30.0, 1.0)]
	for i in range(criterion.point_list.size()):
		assert_almost_eq(criterion.point_list[i].x, exp[i].x, 0.01)
		assert_almost_eq(criterion.point_list[i].y, exp[i].y, 0.01)

	criterion.do_point_append()

	exp = [Vector2(0.0, 0.0),Vector2(10.0, 0.25),Vector2(20.0, 0.50),Vector2(30.0, 0.75),Vector2(40.0, 1.0)]
	for i in range(criterion.point_list.size()):
		assert_almost_eq(criterion.point_list[i].x, exp[i].x, 0.01)
		assert_almost_eq(criterion.point_list[i].y, exp[i].y, 0.01)
