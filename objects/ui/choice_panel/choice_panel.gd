extends Control
class_name ChoicePanel

var criterion: AssessCriterion
var question: Question


func _ready() -> void:
	get_tree().paused = true

	if question == null:
		queue_free()
		return

	%LabelChooseLeft.text = str(question.get_left())
	%LabelChooseRight.text = str(question.get_right())
	%IconChooseLeft.texture = criterion.icon
	%IconChooseRight.texture = criterion.icon
	%LabelName.text = criterion.criterion_name


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:
	criterion.step(AssessCriterion.Answer.p)
	queue_free()


func _on_button_choose_right_pressed() -> void:
	criterion.step(AssessCriterion.Answer.q)
	queue_free()
