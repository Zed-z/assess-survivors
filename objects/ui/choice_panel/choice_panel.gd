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

	if (question.get_left().win_probability == 1):
		%ButtonChooseLeft.text = tr("CHOICE_PANEL_SAFE")
	else:
		%ButtonChooseLeft.text = tr("CHOICE_PANEL_SPIN")

	%LabelChooseRight.text = str(question.get_right())

	if (question.get_right().win_probability == 1):
		%ButtonChooseRight.text = tr("CHOICE_PANEL_SAFE")
	else:
		%ButtonChooseRight.text = tr("CHOICE_PANEL_SPIN")

	%ButtonChooseNone.text = tr("CHOICE_PANEL_NONE")
	%IconChooseLeft.texture = criterion.icon
	%IconChooseRight.texture = criterion.icon
	%LabelName.text = tr(criterion.criterion_name)


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:
	criterion.step(AssessCriterion.Answer.p)
	queue_free()


func _on_button_choose_right_pressed() -> void:
	criterion.step(AssessCriterion.Answer.q)
	queue_free()


func _on_button_choose_none_pressed() -> void:
	criterion.step(AssessCriterion.Answer.i)
	queue_free()
