extends BaseStat
class_name AssessStat

@export var criterion: AssessCriterion
@export var starting_value: int

enum AccumulationMode {
	Replace,
	Add,
	Subtract
}
@export var accumulation_mode: AccumulationMode = AccumulationMode.Add


func increment(val: float) -> void:
	match accumulation_mode:
		AccumulationMode.Replace:
			value = val

		AccumulationMode.Add:
			value += val

		AccumulationMode.Subtract:
			value -= val


func init() -> void:
	GlobalInfo.assess_manager.init_add_criterion(self, criterion)
	value = starting_value

	criterion.value_result.connect(increment)
