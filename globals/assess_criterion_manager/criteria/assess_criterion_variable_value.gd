extends AssessCriterion
class_name AssessCriterionVariableValue


func preferred_left(): # Jeśli preferuje pewnik pogorsz pewnik
	right_bound = point_list[-2].x
	point_list[-2].x = (left_bound + point_list[-2].x) / 2
	#pewniak się robi jako (MIN_value + pewniak) / 2


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
	question.set_right(SingleLottery.new(point_list[-1].x, 1 - point_list[-2].y, MIN_value))
	question_changed.emit(question)


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, 1, -1), SingleLottery.new(point_list[-1].x, 1 - point_list[-2].y,MIN_value))
	question_changed.emit(question)
