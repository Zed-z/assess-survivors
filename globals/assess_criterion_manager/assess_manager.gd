extends Node2D
class_name AssessManager

@onready var algorithm_script: GDScript = preload('res://globals/assess_criterion_manager/assess_decision_algorithm/algorithm_rr.gd') 

@export var criteria_scripts: Array[Script] = []
@export var algorithm: AssessAlgorithm = algorithm_script.new() 
var criteria: Array[AssessCriterion] = []

var decide_value: int = 0

func _ready() -> void:

	for criterion: GDScript in criteria_scripts:
		var c: AssessCriterion = criterion.new()
		criteria.append(c)
		add_child(c)

func display_choice(criterion: AssessCriterion) -> String:
	var left: Lottery = criterion.get_left()
	var right: Lottery = criterion.get_right()
	return left._to_string() + " ? " + right._to_string()
	
func get_criterion() -> AssessCriterion:
	return criteria[algorithm.decide()]
