extends AssessCriterion
class_name AssessCriterionVariableProbability


func preferred_right(): # Loteria, pewnik staje się mniej użyteczny
	right_bound = point_list[-2].y
	point_list[-2].y = (left_bound + point_list[-2].y) / 2
	#pewniak się robi jako (MIN_value + pewniak) / 2


func preferred_left(): # Pewnik, pewnik staje się bardziej użyteczny
	left_bound = point_list[-2].y
	point_list[-2].y = (point_list[-2].y + right_bound) / 2
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2


func set_bound():
	left_bound = point_list[-3].y
	right_bound = point_list[-1].y


func change_question() -> void:
	question.get_left().free()
	question.set_left(SingleLottery.new(point_list[-2].x, 1, -1))
	question.get_right().free()
	question.set_right(SingleLottery.new(point_list[-1].x, point_list[-2].y, MIN_value))


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, 1, -1), SingleLottery.new(point_list[-1].x, point_list[-2].y,MIN_value))
	question_changed.emit(question)
