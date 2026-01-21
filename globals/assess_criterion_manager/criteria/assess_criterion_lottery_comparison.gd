extends AssessCriterion
class_name AssessCriterionLotteryComparison
@export var left_probability: float = 0.75

var right_probability: float


func preferred_right(): #jeśli wybral L(MAX, prob_i, MIN) pogorsz prob_i
	right_bound = right_probability
	right_probability = (left_bound + right_probability) / 2
	point_list[-2].y = right_probability / left_probability


func preferred_left(): #jeśli wybral L( x_i, LP, MIN) to polepsz prob_i 
	left_bound = right_probability
	right_probability = (right_probability + right_bound) / 2
	point_list[-2].y = right_probability / left_probability


func preferred_none(): #jesli obojetnie to przeskaluj
	point_list[-2].y = right_probability / left_probability


func set_bound():
	right_probability = point_list[-2].y * left_probability
	left_bound = point_list[-3].y * left_probability
	right_bound = point_list[-1].y * left_probability


func change_question() -> void:
	question.get_left().free()
	question.set_left(SingleLottery.new(point_list[-2].x, left_probability, min_value))
	question.get_right().free()
	question.set_right(SingleLottery.new(point_list[-1].x, right_probability,min_value))


func _question_init() ->void:
	question = Question.new(SingleLottery.new(point_list[-2].x, left_probability, min_value), SingleLottery.new(point_list[-1].x, point_list[-2].y,min_value))
	question_changed.emit(question)
