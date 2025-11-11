extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
@export var weight_algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")
var algorithm: AssessAlgorithm
var weight_algorithm: AssessAlgorithm

@export var criteria: Array[AssessCriterion] = []
var criteria_weight: Array[float] = []
var decide_value: int = 0


func get_current_decide_criterion() -> AssessCriterion:
	return criteria[decide_value]


func _ready() -> void:
	GlobalInfo.assess_manager = self

	algorithm = algorithm_script.new(criteria)


func display_choice(criterion: AssessCriterion) -> String:
	return criterion.question._to_string()


func init_add_criterion(stat: AssessStat, criterion: AssessCriterion):
	criteria.append(criterion)
	criterion.criterion_name = stat.name
	criterion.icon = stat.icon
	algorithm = algorithm_script.new(criteria)
	criteria_weight.append(0.5)
	weight_algorithm = weight_algorithm_script.new(criteria)


func get_criterion() -> AssessCriterion:
	return criteria[algorithm.decide()]


func get_least_u_on_all() -> Dictionary[String, float]:
	var dictionary: Dictionary[String, float] = {}

	for c in criteria:
		dictionary[c.criterion_name] = c.point_list[0].x

	return dictionary


func get_most_u_on_all()-> Dictionary[String, float]:
	var dictionary: Dictionary[String, float] = {}

	for c in criteria:
		dictionary[c.criterion_name] = c.point_list[-1].x

	return dictionary


func get_most_u_on_criterion(criterion_name: String)-> Dictionary[String, float]:
	var dictionary: Dictionary[String, float] = {}

	for c in criteria:

		if c.name == criterion_name:
			dictionary[c.criterion_name] = c.point_list[-1].x
		else:
			dictionary[c.criterion_name] = c.point_list[0].x

	return dictionary


func get_weight_question() -> Question:
	var index: int = weight_algorithm.decide()
	var win_val_right: Dictionary[String, float] = get_most_u_on_all()
	var loss_val_right: Dictionary[String, float] = get_least_u_on_all()
	var win_val_left: Dictionary[String, float] = get_most_u_on_criterion(criteria[index].criterion_name)
	var left_lottery: MultiLottery = MultiLottery.new(win_val_left, 1, loss_val_right)
	var right_lottery: MultiLottery = MultiLottery.new(win_val_right, criteria_weight[index], loss_val_right)
	return Question.new(left_lottery, right_lottery)
