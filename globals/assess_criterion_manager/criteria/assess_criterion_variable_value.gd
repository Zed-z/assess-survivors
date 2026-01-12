extends AssessCriterion
class_name AssessCriterionVariableValue


func preferred_left(): # Jeśli preferuje pewnik pogorsz pewnik
	right_bound = point_list[-2].x
	point_list[-2].x = (left_bound + point_list[-2].x) / 2
	#pewniak się robi jako (min_value + pewniak) / 2


func preferred_right(): # Jeśli preferuje loterię polepsz pewnik
	left_bound = point_list[-2].x
	point_list[-2].x = (point_list[-2].x + right_bound) / 2
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2


func set_bound():
	left_bound = point_list[-3].x
	right_bound = point_list[-1].x


func change_question() -> void:
	question.get_left().free()
	question.set_left(SingleLottery.new(point_list[-2].x, 1, -1))
	question.get_right().free()
	question.set_right(SingleLottery.new(point_list[-1].x, point_list[-2].y, point_list[-3].x))


func point_inbetween() -> void:
	var val: float = phases[CUR_phase]

	if CUR_phase >= 1:
		val -= phases[CUR_phase - 1]
		val /= (1-phases[CUR_phase-1])

	print(val)
	var new_x = point_list[-2].x*(1-val) + point_list[-1].x*val
	print(new_x)
	var a: float = (new_x-point_list[-2].x)/(point_list[-1].x - point_list[-2].x)
	print(a)
	var point = Vector2(
		new_x,
		point_list[-2].y*(1-a) + point_list[-1].y*a

	)

	point_list.insert(-1, point)
	set_bound()


func preferred_none():
	print("vv")
	print(point_list)
	point_list[-2].y = point_list[-2].y * point_list[-1].y + (1-point_list[-2].y) * point_list[-3].y


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, 1, -1), SingleLottery.new(point_list[-1].x, point_list[-2].y,min_value))
	question_changed.emit(question)
