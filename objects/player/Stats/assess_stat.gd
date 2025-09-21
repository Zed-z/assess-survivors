extends BaseStat
class_name AssessStat

@export var criterion_type: AssessManager.CriteriaType

var value: float = 0


func get_stat() -> float:
	return 0


func init() -> void:
	AssessManager.init_add_criterion(stat_type, criterion_type)
