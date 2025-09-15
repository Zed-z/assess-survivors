extends GutTest


@onready var criterion_script: GDScript = preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_value.gd")

var criterion: AssessCriterion


func assert_almost_eq_vector2_array(actual: Array[Vector2], expected: Array[Vector2], delta: float):
	assert_eq(actual.size(), expected.size())
	for i in range(actual.size()):
		assert_almost_eq(actual[i].x, expected[i].x, delta)
		assert_almost_eq(actual[i].y, expected[i].y, delta)

func before_each():
	criterion = criterion_script.new()
	criterion._ready()
	criterion.MIN_value = 0
	criterion.value_step = 10
	
func after_each():
	criterion.free()

func test_answer_p():
	criterion.step(AssessCriterion.Answer.p)
	assert_almost_eq(criterion.point_list[1].x, 5.0, 0.01)

func test_answer_q():
	criterion.step(AssessCriterion.Answer.q)
	assert_almost_eq(criterion.point_list[1].x, 15.0, 0.01)

func test_answer_i():
	criterion.step(AssessCriterion.Answer.i)
	assert_almost_eq_vector2_array(criterion.point_list, [Vector2(0, 0), Vector2(10, 0.333),Vector2(20, 0.666),Vector2(30, 1)], 0.01)

func test_scenario_1():
	criterion.step(AssessCriterion.Answer.q) #15
	assert_almost_eq(criterion.point_list[-2].x, 15.0, 0.01)
	
	criterion.step(AssessCriterion.Answer.q) #17.5
	assert_almost_eq(criterion.point_list[-2].x, 17.5, 0.01)
	
	criterion.step(AssessCriterion.Answer.i)
	print(criterion.point_list) #skalowanie : 3
	assert_almost_eq(criterion.point_list[-3].y,0.166 , 0.01) #1/6
	assert_almost_eq(criterion.point_list[-2].y, 0.333, 0.01) #1/3
	
	criterion.step(AssessCriterion.Answer.p) # 18.75  
	assert_almost_eq(criterion.point_list[-2].x, 18.75, 0.01)
	
	criterion.step(AssessCriterion.Answer.p) # 18.125
	assert_almost_eq(criterion.point_list[-2].x,  18.125, 0.01) 
	print(criterion.point_list)
	criterion.step(AssessCriterion.Answer.i) #skalowanie : 1.5614
	print(criterion.point_list)
	assert_almost_eq(criterion.point_list[-3].y, 0.213, 0.01) # 1/3 / 1.5614
	assert_almost_eq(criterion.point_list[-2].y,0.640 , 0.01) # 1/1.5614
