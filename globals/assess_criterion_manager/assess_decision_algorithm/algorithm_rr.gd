extends AssessAlgorithm
#round robin
var decide_value: int = -1

func decide() -> int:
	decide_value += 1
	decide_value %= len(criteria)
	return decide_value
