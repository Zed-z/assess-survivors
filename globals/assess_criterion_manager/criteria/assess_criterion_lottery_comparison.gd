extends AssessCriterion
class_name AssessCriterionLotteryComparison
@export var left_probability: float = 0.75


func preferred_right(): #jeśli wybral L(MAX, prob_i, MIN) pogorsz prob_i
	right_bound = point_list[-2].y
	point_list[-2].y = (left_bound + point_list[-2].y) / 2


func preferred_left(): #jeśli wybral L( x_i, LP, MIN) to polepsz prob_i 
	left_bound = point_list[-2].y
	point_list[-2].y = (point_list[-2].y + right_bound) / 2


func preferred_none(): #jesli obojetnie to przeskaluj
	#print("lc")
	#print(point_list)
	point_list[-2].y /= left_probability
	#print(point_list[-2].y)


func set_bound():
	left_bound = point_list[-3].y
	right_bound = point_list[-1].y


func change_question() -> void:
	question.get_left().free()
	question.set_left(SingleLottery.new(point_list[-2].x, left_probability, min_value))
	question.get_right().free()
	question.set_right(SingleLottery.new(point_list[-1].x, point_list[-2].y,min_value))


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, left_probability, min_value), SingleLottery.new(point_list[-1].x, point_list[-2].y,min_value))
	question_changed.emit(question)
