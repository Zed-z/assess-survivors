extends Node

class_name AssessAlgorithm
var criteria: Array[AssessCriterion]
var weight: bool


func is_choice_invalid(c) -> bool:
	if !weight:
		return(c.LIMIT_expand_count > 0 and c.METRIC_expand_count >= c.LIMIT_expand_count)
	else:
		return(c.LIMIT_count_weight > 0
			and c.METRIC_count_weight >= c.LIMIT_count_weight)


func _init(criteria_list: Array[AssessCriterion]) -> void:
	criteria = criteria_list


func decide() -> int:
	return 0
