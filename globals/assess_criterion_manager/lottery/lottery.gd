extends Node

class_name Lottery

var win_value: float
var loss_value: float
var win_probability: float
var loss_probability: float


func _init(win_val, win_prob, loss_val) -> void:
	win_value = win_val
	win_probability = win_prob
	loss_value = loss_val
	loss_probability = 1 - win_prob


func copy() -> Lottery:
	return Lottery.new(win_value, win_probability, loss_value)


func _to_string() -> String:
	if win_probability == 1:
		return "%.02f" % win_value

	return "L(%.02f, %.02f%%, %.02f)" % [win_value, (win_probability * 100), loss_value]
