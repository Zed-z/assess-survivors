extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
@export var weight_algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
var algorithm: AssessAlgorithm
var weight_algorithm: AssessAlgorithm

@export var criteria: Array[AssessCriterion] = []
@export var criteria_weight: Array[float] = []
var lower_bound_weight: Array[float] = []
var upper_bound_weight: Array[float] = []
var weight_question: Question
var weight_index: int

var is_weight_phase: bool = false


func init_choice_panel() -> ChoicePanel:
	var choice_panel: ChoicePanel = ObjectManager.instantiate(ObjectManager.OBJ_CHOICE_PANEL)

	if !is_weight_phase:
		choice_panel.criterion = get_criterion()

		if choice_panel.criterion != null:
			choice_panel.question = choice_panel.criterion.get_question()
		else:
			is_weight_phase = true

	if is_weight_phase:
		choice_panel.question = get_weight_question()
		choice_panel.criterion = get_weight_criterion()

	choice_panel.is_weight_phase = is_weight_phase
	return choice_panel


func _ready() -> void:
	GlobalInfo.assess_manager = self

	algorithm = algorithm_script.new(criteria)

	for criterion: AssessCriterion in criteria:
		register_criterion(criterion)


func display_choice(criterion: AssessCriterion) -> String:
	return criterion.question._to_string()


func init_add_criterion(stat: AssessStat, criterion: AssessCriterion):
	criteria.append(criterion)
	criterion.criterion_name = stat.name
	criterion.icon = stat.icon
	register_criterion(criterion)


func register_criterion(criterion: AssessCriterion) -> void:
	algorithm = algorithm_script.new(criteria)
	criteria_weight.append(0.5)
	lower_bound_weight.append(0)
	upper_bound_weight.append(1)
	weight_algorithm = weight_algorithm_script.new(criteria)


func get_criterion() -> AssessCriterion:
	var val = algorithm.decide()

	if val >= 0:
		return criteria[val]
	else:
		return null


func get_least_u_on_all() -> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:
		dictionary[c] = c.point_list[0].x

	return dictionary


func get_most_u_on_all()-> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:
		dictionary[c] = c.point_list[-1].x

	return dictionary


func get_most_u_on_criterion(criterion_name: String)-> Dictionary[AssessCriterion, float]:
	var dictionary: Dictionary[AssessCriterion, float] = {}

	for c in criteria:

		if c.criterion_name == criterion_name:
			dictionary[c] = c.point_list[-1].x
		else:
			dictionary[c] = c.point_list[0].x

	return dictionary


func get_weight_question() -> Question:
	weight_index = weight_algorithm.decide()
	var win_val_right: Dictionary[AssessCriterion, float] = get_most_u_on_all()
	var loss_val_right: Dictionary[AssessCriterion, float] = get_least_u_on_all()
	var win_val_left: Dictionary[AssessCriterion, float] = get_most_u_on_criterion(criteria[weight_index].criterion_name)
	var left_lottery: MultiLottery = MultiLottery.new(win_val_left, 1, loss_val_right)
	var right_lottery: MultiLottery = MultiLottery.new(win_val_right, criteria_weight[weight_index], loss_val_right)
	weight_question = Question.new(left_lottery, right_lottery)
	return weight_question


func get_weight_criterion() -> AssessCriterion:
	return criteria[weight_index]


class WeightStepAnswer:
	var value: MultiLottery.MultiLotteryResult
	var answer: AssessCriterion.Answer


func weight_step(answer: AssessCriterion.Answer) -> WeightStepAnswer:
	var step_answer: WeightStepAnswer = WeightStepAnswer.new()
	var result: MultiLottery.MultiLotteryResult
	step_answer.answer = answer

	if (answer == AssessCriterion.Answer.p):
		lower_bound_weight[weight_index] = criteria_weight[weight_index]
		criteria_weight[weight_index] = (criteria_weight[weight_index] + upper_bound_weight[weight_index])/2
		result = weight_question.get_left().get_value()

	if (answer == AssessCriterion.Answer.q):
		upper_bound_weight[weight_index] = criteria_weight[weight_index]
		criteria_weight[weight_index] = (criteria_weight[weight_index] + lower_bound_weight[weight_index])/2
		result = weight_question.get_right().get_value()

	if (answer == AssessCriterion.Answer.i):
		upper_bound_weight[weight_index] = criteria_weight[weight_index]
		lower_bound_weight[weight_index] = criteria_weight[weight_index]

		if randf() <= 0.5:
			result = weight_question.get_left().get_value()
			step_answer.answer = AssessCriterion.Answer.p
		else:
			result = weight_question.get_right().get_value()
			step_answer.answer = AssessCriterion.Answer.q

	step_answer.value = result

	for c in result.values:
		print(result.values[c])
		c.value_result.emit(result.values[c])

	return step_answer
