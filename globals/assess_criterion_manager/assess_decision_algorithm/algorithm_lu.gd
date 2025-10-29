extends AssessAlgorithm
# Least Used
var usage: Array[int]
func _init(criteria_list: Array[AssessCriterion]) -> void:
	criteria = criteria_list
	for c in criteria:
		usage.append(0)

func decide() -> int:
	var index = usage.find(usage.min())
	usage[index] += 1
	return index
