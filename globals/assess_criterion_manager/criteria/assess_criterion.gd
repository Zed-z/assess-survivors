extends Node2D
class_name AssessCriterion

signal points_changed(points: Array[Vector2Decimal])

@export var criterion_name: String = ""
var MIN_value: Decimal = Decimal.new(0, 1)
var value_step: Decimal = Decimal.new(10, 1)
var MAX_value: Decimal = Decimal.new(100, 1)

var UTILITY_MIN: Decimal = Decimal.new(0, 1)
var UTILITY_MAX: Decimal = Decimal.new(1, 1)
enum Answer {
	i, # Indifferent
	p, # Prefer left
	q, # prefer right
}

var MAX_dialog_answers: int = 2
var dialog_answers_count: int = 0

var first_answer: bool = true
var is_risky: bool

var point_list: Array[Vector2Decimal] = [
	Vector2Decimal.new(MIN_value, UTILITY_MIN),
	Vector2Decimal.new(MIN_value.added(value_step), UTILITY_MAX)
]
var left_bound: Decimal
var right_bound: Decimal


func get_left() -> Lottery:
	return Lottery.new(-1,-1,-1)


func get_right() -> Lottery:
	return Lottery.new(-1,-1,-1)


func step(answer: Answer):
	match answer:
		Answer.p:
			do_preferred_left()
			if first_answer:
				is_risky = false
				first_answer = true

			dialog_answers_count += 1

		Answer.q:
			do_preferred_right()
			if first_answer:
				is_risky = false
				first_answer = true

			dialog_answers_count += 1

		Answer.i:
			do_point_append()
			dialog_answers_count = 0

	if dialog_answers_count > MAX_dialog_answers:
		do_point_append()
		dialog_answers_count = 0


func do_point_append():
	point_append()
	points_changed.emit(point_list)


func point_append():
	#stwórz nowy punkt na podstawie poprzednich
	var a: Decimal = (point_list[-1].y.subtract(point_list[-2].y)).divided(point_list[-1].x.subtract(point_list[-2].x))
	var new_max = Vector2Decimal.new(point_list[-1].x.added(value_step),point_list[-1].y.added(a.multiplied(value_step)))

	point_list.append(new_max)

	#zeskaluj
	for i in range(len(point_list)):
		point_list[i].y = point_list[i].y.divided(point_list[-1].y)

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


func _ready() -> void:
	do_point_append()
