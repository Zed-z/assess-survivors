extends AssessAlgorithm
# Least Used
const INFINITY: int = 999999
var usage: Dictionary[AssessCriterion,int]


func _init() -> void:
	for c in criteria:
		usage[c] = 0


func decide() -> int:
	var min_value: int = INFINITY
	var filtered: Array[AssessCriterion] = criteria.filter(func(x): return !is_choice_invalid(x))
	#if nothing to choose from
	if len(filtered) == 0:
		return -1

	for c in filtered:
		min_value = min(min_value, usage[c])

	filtered = filtered.filter(func(x): return usage[x] == min_value)
	var chosen: AssessCriterion = filtered.pick_random()

	usage[chosen] += 1
	return usage[chosen]
