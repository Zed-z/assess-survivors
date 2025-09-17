extends Node

class_name Lottery

@export var win_value : float
@export var win_probability : float
@export var loss_probability : float
@export var loss_value: float

func _init(win_val, win_prob, loss_val) -> void:
	win_value = win_val
	win_probability = win_prob
	loss_value = loss_val
	loss_probability = 1 - win_prob

func _to_string() -> String:
	return "("+"%.02f" % win_value +","+"%.02f" % win_probability +","+"%.02f" % loss_value + ")"
