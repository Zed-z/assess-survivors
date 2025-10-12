extends BaseStat
class_name AssessStat

@export var criterion: AssessCriterion


func increment(val: float) -> void:
	value += val


func init() -> void:
	GlobalInfo.assess_manager.init_add_criterion(self, criterion)
	value = criterion.MIN_value
	criterion.value_result.connect(increment)
