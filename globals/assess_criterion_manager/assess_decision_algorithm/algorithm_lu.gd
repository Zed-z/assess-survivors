extends AssessAlgorithm
# Least Used
var usage: Array[int]


func _init() -> void:
	for c in range(len(criteria)):
		usage.append(0)


func decide() -> int:
	var index = usage.find(usage.min())
	usage[index] += 1
	return index
