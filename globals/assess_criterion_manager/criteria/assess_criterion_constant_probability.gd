extends AssessCriterion
class_name AssessCriterionConstantProbability

const right_probability = 0.5


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
	question.set_right(SingleLottery.new(point_list[-1].x, right_probability, point_list[-3].x))

#override phases to only have one constant probability
func specific_setup()->void:
	phases = [right_probability]


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, 1, -1), SingleLottery.new(point_list[-1].x, right_probability,min_value))
	question_changed.emit(question)
