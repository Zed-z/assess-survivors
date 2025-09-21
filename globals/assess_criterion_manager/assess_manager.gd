extends Node2D
class_name AssessManagerClass

@export var algorithm_script: GDScript = preload('res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd')
@export var criteria_scripts: Array[Script] = []

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


func _ready() -> void:

	for criterion: GDScript in criteria_scripts:
		var c: AssessCriterion = criterion.new()
		#criteria.append(c)
		add_child(c)

	#algorithm = algorithm_script.new(criteria)


func display_choice(criterion: AssessCriterion) -> String:
	var left: Lottery = criterion.get_left()
	var right: Lottery = criterion.get_right()
	return left._to_string() + " ? " + right._to_string()


func init_add_criterion(stat: PlayerStats.STATS, type: CriteriaType):
	var c: AssessCriterion = criteria_type_script[type].new()
	criteria[stat] = c
	add_child(c)


func get_criterion() -> AssessCriterion:
	return criteria[algorithm.decide()]
