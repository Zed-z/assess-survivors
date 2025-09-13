extends Node2D
class_name Criterion

signal points_changed(points: Array[Vector2])

@export var criterion_name: String = ""
@export var MIN_value: float = 0.0
@export var value_step: float = 10.0
@export var MAX_value: float = 100.0

enum Answer {
	i, p, q,
}
# indiffrent, preferred, preferred but reversed

var MAX_dialog_answers: int = 20
var dialog_answers_count: int = 0


var point_list : Array[Vector2] = [Vector2(MIN_value, 0.0),Vector2(MIN_value + value_step, 1.0)]

var left_bound : float
var right_bound : float
func step(answer: Answer):
	#preferred pewnik
	if answer == Answer.p:
		preferred_val()
		dialog_answers_count += 1
	#preferred loteria
	elif answer == Answer.q:
		preferred_lottery()
		dialog_answers_count += 1
	#indiffrent to both
	elif answer == Answer.i:
		point_append()
		dialog_answers_count = 0
		#reset licznika dialogu
	if dialog_answers_count >= MAX_dialog_answers:
		point_append()
		dialog_answers_count = 0

func point_append():
	#stwórz nowy punkt na podstawie poprzednich
	var a: float = (point_list[-1].y - point_list[-2].y)/ (point_list[-1].x - point_list[-2].x)
	var new_max = Vector2(point_list[-1].x + value_step, point_list[-1].y + a * value_step)

	point_list.append(new_max)

	#zeskaluj
	for i in range(len(point_list)):
		point_list[i].y /= point_list[-1].y
	set_bound()
	points_changed.emit(point_list)

func preferred_val():
	right_bound = point_list[-2].y
	point_list[-2].y = (left_bound + point_list[-2].y) / 2
	#pewniak się robi jako (MIN_value + pewniak) / 2
	points_changed.emit(point_list)

func preferred_lottery():
	left_bound = point_list[-2].y
	point_list[-2].y = (point_list[-2].y + right_bound) / 2
	#pewniak się robi jako (pewniak + CUR_MAX_value) / 2
	points_changed.emit(point_list)


func set_bound():
	left_bound = point_list[-3].y
	right_bound = point_list[-1].y

func _ready() -> void:
	point_append()
	print(point_list)


func _on_punkt_dodaj_pressed() -> void:
	point_append()
	print(point_list)


func _on_obojętnie_pressed() -> void:
	step(Answer.i)
	print(point_list)

func _on_loteria_pressed() -> void:
	step(Answer.q)
	print(point_list)


func _on_pewnik_pressed() -> void:
	step(Answer.p)
	print(point_list)


func _on_scenariusz_pressed() -> void:
	step(Answer.p)
	step(Answer.q)
	step(Answer.i)

	step(Answer.p)
	step(Answer.q)
	step(Answer.i)

	step(Answer.q)
	step(Answer.p)
	step(Answer.i)

	step(Answer.p)
	step(Answer.p)
	step(Answer.i)

	step(Answer.q)
	step(Answer.q)
	step(Answer.i)

	step(Answer.p)
	step(Answer.p)
	step(Answer.i)


	step(Answer.q)
	step(Answer.q)
	step(Answer.i)


	step(Answer.p)
	step(Answer.p)
	#step(Answer.i)
	print(point_list)
