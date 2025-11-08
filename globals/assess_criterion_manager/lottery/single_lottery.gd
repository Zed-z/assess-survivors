extends Lottery

class_name SingleLottery

var win_value: float
var loss_value: float


func _init(win_val, win_prob, loss_val) -> void:
	win_value = win_val
	win_probability = win_prob
	loss_value = loss_val
	loss_probability = 1 - win_prob


func copy() -> SingleLottery:
	return SingleLottery.new(win_value, win_probability, loss_value)


func _to_string() -> String:
	if win_probability == 1:
		return "%.02f" % win_value

	return "L(%.02f, %.02f%%, %.02f)" % [win_value, (win_probability * 100), loss_value]


func _to_pretty_string() -> String:
	if win_probability == 1:
		return "%.02f" % win_value

	return "%.02f %.02f%%\n%.02f %.02f%%" % [win_value, (win_probability * 100), loss_value, (loss_probability * 100)]


func get_value() -> float:
	var random_float: float = randf_range(0.0, 1.0)

	if random_float <= win_probability:
		return win_value

	return loss_value
