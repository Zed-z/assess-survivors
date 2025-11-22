extends Resource
class_name AssessCriterion

signal points_changed(points: Array[Vector2])
signal value_result(value: float) # Result of making a choice and the random stuff happening
signal question_changed(question: Question)

@export var criterion_name: String = ""
@export var icon: CompressedTexture2D

@export var min_value: float = 0 # starting value for criterion
@export var value_step: float = 10 # additive value used for increasing interval
@export var initial_max_value: float = 10

@export_range(1,10,0.1,"or_greater") var value_mult: float = 1 # multiplicative value used for increasing interval
@export var phases: Array[float] = [1/3.0, 2/3.0] # floats describing points in newly added interval
#do not touch those values unless, you know what you are doing
var UTILITY_MIN: float = 0
var UTILITY_MAX: float = 1
var CUR_phase: int = 0
var last_significant_index: int = 0

var MAX_dialog_answers: int = 2
var dialog_answers_count: int = 0

enum Answer {
	i, # Indifferent
	p, # Prefer left
	q, # prefer right
}
enum RiskCalculationMode{
	area_minus_perfectline,
	area_minus_perfectline_over_perfectline
}
@export var risk_method: RiskCalculationMode = RiskCalculationMode.area_minus_perfectline_over_perfectline
var risk_factor: float:
	get:
		return _calculate_risk_factor(risk_method)

var point_list: Array[Vector2] = [
	Vector2(min_value, UTILITY_MIN),
	Vector2(initial_max_value, UTILITY_MAX)
]
var question: Question
var left_bound: float
var right_bound: float


class StepAnswer:
	var answer: Answer
	var value: SingleLottery.SingleLotteryResult


func step(answer: Answer) -> StepAnswer:
	var result: SingleLottery.SingleLotteryResult

	var ret: StepAnswer = StepAnswer.new()
	ret.answer = answer

	match answer:
		Answer.p:
			result = question.get_left().get_value()
			do_preferred_left()

			dialog_answers_count += 1

		Answer.q:
			result = question.get_right().get_value()
			do_preferred_right()

			dialog_answers_count += 1

		Answer.i:
			if randf() <= 0.5:
				result = question.get_left().get_value()
				ret.answer = Answer.p
			else:
				result = question.get_right().get_value()
				ret.answer = Answer.q

			do_preferred_none()
			dialog_answers_count = 0

	if dialog_answers_count > MAX_dialog_answers:
		do_preferred_none()
		dialog_answers_count = 0

	do_change_question()

	value_result.emit(result.value)

	ret.value = result
	return ret


func do_point_append():
	point_append()
	points_changed.emit(point_list)


func point_append():
	#stwórz nowy punkt na podstawie poprzednich
	var a: float = (point_list[-1].y - point_list[-2].y) / (point_list[-1].x - point_list[-2].x)
	var new_x: float = value_mult*point_list[-1].x + value_step
	var new_y: float = point_list[-1].y + a * (new_x - point_list[-1].x)
	var new_max = Vector2(
		new_x,
		new_y
		)

	point_list.append(new_max)
	#zeskaluj
	for i in range(len(point_list)):
		point_list[i].y = point_list[i].y / point_list[-1].y

	set_bound()


func do_point_inbetween() -> void:
	point_inbetween()
	CUR_phase += 1
	points_changed.emit(point_list)


func point_inbetween() -> void:
	var val: float = phases[CUR_phase]

	var new_x = point_list[last_significant_index].x*(1-val) + point_list[-1].x*val
	var a: float = (new_x-point_list[-2].x)/(point_list[-1].x - point_list[-2].x)
	var point = Vector2(
		new_x,
		point_list[-2].y*(1-a) + point_list[-1].y*a

	)

	point_list.insert(-1, point)
	set_bound()


func do_preferred_left():
	preferred_left()
	points_changed.emit(point_list)


func preferred_left():
	pass


func do_preferred_right():
	preferred_right()
	points_changed.emit(point_list)


func preferred_right():
	pass


func do_preferred_none():
	preferred_none()
	if CUR_phase >= len(phases):
		do_point_append()
		CUR_phase = 0
		last_significant_index = len(point_list) - 2
	else:
		do_point_inbetween()


func preferred_none():
	pass


func set_bound():
	pass


func get_question() -> Question:
	return question


func _question_init() ->void:
	pass


func do_change_question() -> void:
	change_question()
	question_changed.emit(question)


func change_question() -> void:
	pass


func _area_under_graph() -> float:
	var area: float = 0.0

	for i in range(len(point_list) - 1):
		area += (point_list[i+1].y + point_list[i].y) * (point_list[i+1].x - point_list[i].x) / 2

	return area


func _area_under_line():
	return(point_list[-1].x - point_list[0].x) * 1 / 2


func _calculate_risk_factor(method: RiskCalculationMode) -> float:
	match method:
		RiskCalculationMode.area_minus_perfectline:
			return _area_under_graph() - _area_under_line()

		RiskCalculationMode.area_minus_perfectline_over_perfectline:
			var perfectline: float = _area_under_line()
			return _area_under_line() - perfectline / perfectline

	return 0.0


func _init() -> void:
	do_point_inbetween()
	_question_init()
	#print(point_list)
