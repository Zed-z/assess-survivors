extends Lottery

class_name MultiLottery

var win_array: Dictionary[String, float]
var loss_array: Dictionary[String, float]


func _init(win_val: Dictionary[String, float], win_prob: float, loss_val: Dictionary[String, float]) -> void:
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


func get_value() -> Dictionary[String,float]:
	var random_float: float = randf_range(0.0, 1.0)

	if random_float <= win_probability:
		return win_array

	return loss_array
