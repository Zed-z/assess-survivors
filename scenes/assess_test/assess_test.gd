extends Control

var value: float = 0

@onready var assess_criteria := GlobalInfo.assess_manager.criteria


func update_value(_name: String, _value: float):
	value += _value
	%Value.text = "%s\n%s\n(+%s)" % [_name, value, _value]


func update_text(question: Question):
	%AssessQuestion.text = str(question)


func _ready() -> void:

	assess_criteria[0].points_changed.connect(%ChartVisualizer.set_points)
	%ChartVisualizer.set_points(assess_criteria[0].point_list)

	assess_criteria[0].question_changed.connect(update_text)
	update_text(assess_criteria[0].get_question())

	assess_criteria[0].value_result.connect(update_value.bind(assess_criteria[0].criterion_name))
	update_value(assess_criteria[0].criterion_name, 0)


func _on_button_left_pressed() -> void:
	assess_criteria[0].step(AssessCriterion.Answer.p)
	print(assess_criteria[0].point_list)


func _on_button_right_pressed() -> void:
	assess_criteria[0].step(AssessCriterion.Answer.q)
	print(assess_criteria[0].point_list)


func _on_button_indifferent_pressed() -> void:
	assess_criteria[0].step(AssessCriterion.Answer.i)
	print(assess_criteria[0].point_list)


func _on_button_scenario_pressed() -> void:
	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.q)
	assess_criteria[0].step(AssessCriterion.Answer.i)

	assess_criteria[0].step(AssessCriterion.Answer.p)
	assess_criteria[0].step(AssessCriterion.Answer.p)
	#step(Answer.i)

	print(assess_criteria[0].point_list)
