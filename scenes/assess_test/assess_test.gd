extends Control

var value: float = 0

@onready var assess_criteria := GlobalInfo.assess_manager.criteria
@onready var chart_visualizers: Array[ChartVisualizer] = [
	%ChartVisualizer, %ChartVisualizer2
]
var current_critetion: AssessCriterion = null


func update_value(_value: float, _name: String, _visualizer: ChartVisualizer):
	value += _value
	_visualizer.set_title("%s: %s (+%s)" % [_name, value, _value])


func update_question():
	update_text(current_critetion.get_question(), current_critetion.criterion_name)


func update_text(question: Question, _name: String):
	%AssessQuestion.text = "%s: %s" % [_name, question]


func _ready() -> void:

	current_critetion = GlobalInfo.assess_manager.criteria[GlobalInfo.assess_manager.get_current_decide_criterion()]

	for i in len(assess_criteria):
		var key: int = assess_criteria.keys()[i]

		var chart: ChartVisualizer = ObjectManager.instantiate(ObjectManager.OBJ_CHART_VISUALIZER)
		%ChartContainer.add_child(chart)

		assess_criteria[key].points_changed.connect(chart.set_points)
		chart.set_points(assess_criteria[key].point_list)

		#assess_criteria[key].question_changed.connect(update_text.bind(assess_criteria[key].criterion_name))
		#update_text(assess_criteria[key].get_question(), assess_criteria[key].criterion_name)

		assess_criteria[key].value_result.connect(update_value.bind(assess_criteria[key].criterion_name, chart))
		update_value(0, assess_criteria[key].criterion_name, chart)

	update_question()


func _on_button_left_pressed() -> void:
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion = GlobalInfo.assess_manager.get_criterion()
	update_question()


func _on_button_right_pressed() -> void:
	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion = GlobalInfo.assess_manager.get_criterion()
	update_question()


func _on_button_indifferent_pressed() -> void:
	current_critetion.step(AssessCriterion.Answer.i)
	current_critetion = GlobalInfo.assess_manager.get_criterion()
	update_question()


func _on_button_scenario_pressed() -> void:
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.q)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.p)
	current_critetion.step(AssessCriterion.Answer.i)

	current_critetion = GlobalInfo.assess_manager.get_criterion()
	update_question()
