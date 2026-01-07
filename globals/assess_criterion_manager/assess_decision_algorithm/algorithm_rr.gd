extends AssessAlgorithm
#round robin
var decide_value: int = -1


func decide() -> int:
	if criteria.all(is_choice_invalid):
		return -1

	decide_value += 1
	decide_value %= len(criteria)
	var criterion: AssessCriterion = criteria[decide_value]

	if is_choice_invalid(criterion):
		decide_value = decide()

	return decide_value
