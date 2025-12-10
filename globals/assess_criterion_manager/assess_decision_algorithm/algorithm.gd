extends Node

class_name AssessAlgorithm
var criteria: Array[AssessCriterion]


func is_choice_invalid(c) -> bool:
	return(c.LIMIT_expand_count > 0 and c.METRIC_expand_count >= c.LIMIT_expand_count)


func _init(criteria_list: Array[AssessCriterion]) -> void:
	criteria = criteria_list


func decide() -> int:
	return 0
