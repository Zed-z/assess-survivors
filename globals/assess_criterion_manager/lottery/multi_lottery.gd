extends Lottery

class_name MultiLottery

var win_array: Dictionary[AssessCriterion, float]
var loss_array: Dictionary[AssessCriterion, float]


func _init(win_val: Dictionary[AssessCriterion, float], win_prob: float, loss_val: Dictionary[AssessCriterion, float]) -> void:
	win_array = win_val
	win_probability = win_prob
	loss_array = loss_val
	loss_probability = 1 - win_prob


func copy() -> MultiLottery:
	return MultiLottery.new(win_array, win_probability, loss_array)


func _to_string() -> String:
	var win_string: String = "["
	var loss_string: String = "["

	for key in win_array:
		win_string += "%s : %.02f" % [key, win_array[key]]

		if key != win_array.keys()[-1]:
			win_string += ", "

	win_string += "]"

	for key in loss_array:
		loss_string += "%s : %.02f" % [key, loss_array[key]]

		if key != loss_array.keys()[-1]:
			loss_string += ", "

	loss_string += "]"

	if win_probability >= 1:
		return win_string

	return "L(%s, %.02f%%, %s)" % [win_string, (win_probability*100), loss_string]


class MultiLotteryResult:
	var values: Dictionary[AssessCriterion, float]
	var win: bool


	func _init(_values: Dictionary[AssessCriterion, float], _win: bool) -> void:
		values = _values
		win = _win


func get_value() -> MultiLotteryResult:
	var random_float: float = randf_range(0.0, 1.0)

	if random_float <= win_probability:
		return MultiLotteryResult.new(win_array, true)

	return MultiLotteryResult.new(loss_array, false)
