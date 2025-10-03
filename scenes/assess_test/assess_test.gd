extends Control

var value: float = 0

@onready var assess_criteria := GlobalInfo.assess_manager.criteria
@onready var chart_visualizers: Array[ChartVisualizer] = [
	%ChartVisualizer, %ChartVisualizer2
]


func update_value(_value: float, _name: String, _visualizer: int):
	value += _value
	chart_visualizers[_visualizer].set_title("%s: %s (+%s)" % [_name, value, _value])


func update_text(question: Question, _name: String):
	%AssessQuestion.text = "%s: %s" % [_name, question]


func _ready() -> void:

	for i in len(assess_criteria):
		var key: int = assess_criteria.keys()[i]

		assess_criteria[key].points_changed.connect(chart_visualizers[i].set_points)
		chart_visualizers[i].set_points(assess_criteria[key].point_list)

		assess_criteria[key].question_changed.connect(update_text.bind(assess_criteria[key].criterion_name))
		update_text(assess_criteria[key].get_question(), assess_criteria[key].criterion_name)

		assess_criteria[key].value_result.connect(update_value.bind(assess_criteria[key].criterion_name, i))
		update_value(0, assess_criteria[key].criterion_name, i)


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
