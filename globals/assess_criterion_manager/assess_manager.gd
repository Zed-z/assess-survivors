extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")

var algorithm: AssessAlgorithm
@export var criteria: Array[AssessCriterion] = []

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
	algorithm = algorithm_script.new(criteria)


func get_criterion() -> AssessCriterion:
	return criteria[algorithm.decide()]
