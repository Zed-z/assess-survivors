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

	current_critetion = GlobalInfo.assess_manager.get_criterion()

	for c in assess_criteria:

		var chart: ChartVisualizer = ObjectManager.instantiate(ObjectManager.OBJ_CHART_VISUALIZER)
		%ChartContainer.add_child(chart)

		c.points_changed.connect(chart.set_points)
		chart.set_points(c.point_list)

		#c.question_changed.connect(update_text.bind(c.criterion_name))
		#update_text(c.get_question(), c.criterion_name)

		c.value_result.connect(update_value.bind(c.criterion_name, chart))
		update_value(0, c.criterion_name, chart)

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
