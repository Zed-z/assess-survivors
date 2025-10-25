extends BaseStat
class_name AssessStat

@export var criterion: AssessCriterion
@export var starting_value: int


func increment(val: float) -> void:
	value += val


func init() -> void:
	GlobalInfo.assess_manager.init_add_criterion(self, criterion)
	value = starting_value

	criterion.value_result.connect(increment)
