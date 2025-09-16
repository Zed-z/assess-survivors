extends Node

class_name Lottery

@export var win_value : float
@export var win_probability : float
@export var loss_probability : float
@export var loss_value: float

func _to_string() -> String:
	return "(" 
	#+ "," + + String(loss_value) + ")"
