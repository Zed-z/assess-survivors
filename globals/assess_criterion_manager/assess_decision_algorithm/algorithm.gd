extends Node

class_name AssessAlgorithm
var criteria: Array[AssessCriterion]

func _init(criteria_list: Array[AssessCriterion]) -> void:
	criteria = criteria_list

func decide() -> int:
	return 0
