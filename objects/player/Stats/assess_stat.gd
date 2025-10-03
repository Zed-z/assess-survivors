extends BaseStat
class_name AssessStat

@export var criterion_type: AssessManagerClass.CriteriaType

var value: float = 0


func get_stat() -> float:
	return 0


func init() -> void:
	GlobalInfo.assess_manager.init_add_criterion(stat_type, criterion_type)
