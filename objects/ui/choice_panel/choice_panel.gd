extends Control
class_name ChoicePanel

var criterion: AssessCriterion
var question: Question


func _ready() -> void:
	get_tree().paused = true

	if question == null:
		queue_free()
		return

	$MarginContainer/HBoxContainer/Panel/VBoxContainer/Label.text = str(question.get_left())
	$MarginContainer/HBoxContainer/Panel2/VBoxContainer3/Label.text = str(question.get_right())


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:
	criterion.step(AssessCriterion.Answer.p)
	queue_free()


func _on_button_choose_right_pressed() -> void:
	criterion.step(AssessCriterion.Answer.q)
	queue_free()
