extends Node2D
class_name AssessCriterion

signal points_changed(points: Array[Vector2])
signal value_result(value: float) # Result of making a choice and the random stuff happening
signal question_changed(question: Array[Lottery])

@export var criterion_name: String = ""
@export var MIN_value: float = 0
@export var value_step: float = 10
@export var MAX_value: float = 100

@export var UTILITY_MIN: float = 0
@export var UTILITY_MAX: float = 1
enum Answer {
	i, # Indifferent
	p, # Prefer left
	q, # prefer right
}

var MAX_dialog_answers: int = 2
var dialog_answers_count: int = 0

var first_answer: bool = true
var is_risky: bool

var point_list: Array[Vector2] = [
	Vector2(MIN_value, UTILITY_MIN),
	Vector2(MIN_value + value_step, UTILITY_MAX)
]
var question: Array[Lottery] = []
var left_bound: float
var right_bound: float


func step(answer: Answer):
	var result: float

	match answer:
		Answer.p:
			result = question[0].get_value()
			do_preferred_left()
			if first_answer:
				is_risky = false
				first_answer = true

			dialog_answers_count += 1

		Answer.q:
			result = question[1].get_value()
			do_preferred_right()
			if first_answer:
				is_risky = false
				first_answer = true

			dialog_answers_count += 1

		Answer.i:
			result = question.pick_random().get_value()
			do_point_append()
			dialog_answers_count = 0

	if dialog_answers_count > MAX_dialog_answers:
		do_point_append()
		dialog_answers_count = 0

	change_question()

	value_result.emit(result)


func do_point_append():
	point_append()
	points_changed.emit(point_list)


func point_append():
	#stwórz nowy punkt na podstawie poprzednich
	var a: float = (point_list[-1].y - point_list[-2].y) / (point_list[-1].x - point_list[-2].x)

	var new_max = Vector2(
		point_list[-1].x + value_step,
		point_list[-1].y + a * value_step)

	point_list.append(new_max)

	#zeskaluj
	for i in range(len(point_list)):
		point_list[i].y = point_list[i].y / point_list[-1].y

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


func set_bound():
	pass


func get_question() -> Array[Lottery]:
	return question


func _question_init() ->void:
	pass


func change_question() -> void:
	pass


func _ready() -> void:
	do_point_append()
	_question_init()
