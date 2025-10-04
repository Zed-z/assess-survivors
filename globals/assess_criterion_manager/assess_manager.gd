extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload("res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd")

var algorithm: AssessAlgorithm
var criteria: Dictionary[PlayerStats.STATS, AssessCriterion] = {}

enum CriteriaType {
	VariableProbability,
	VariableValue,
}

var criteria_type_script: Dictionary[CriteriaType, GDScript] = {
	CriteriaType.VariableProbability: preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_probability.gd"),
	CriteriaType.VariableValue: preload("res://globals/assess_criterion_manager/criteria/assess_criterion_variable_value.gd"),
}

var decide_value: int = 0


func get_current_decide_criterion() -> PlayerStats.STATS:
	return criteria.keys()[decide_value]


func _ready() -> void:
	GlobalInfo.assess_manager = self

	algorithm = algorithm_script.new(criteria.values())


func display_choice(criterion: AssessCriterion) -> String:
	return criterion.question._to_string()


func init_add_criterion(stat: PlayerStats.STATS, type: CriteriaType):
	var c: AssessCriterion = criteria_type_script[type].new()
	c.criterion_name = PlayerStats.STATS.keys()[stat]
	criteria[stat] = c
	add_child(c)
	algorithm = algorithm_script.new(criteria.values())


func get_criterion() -> AssessCriterion:
	return criteria[criteria.keys()[algorithm.decide()]]
