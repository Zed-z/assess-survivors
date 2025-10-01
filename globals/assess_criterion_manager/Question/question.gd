extends Node
class_name Question

var left: Lottery
var right: Lottery


func _init(l: Lottery, r: Lottery) -> void:
	left = l
	right = r
	return


func _to_string() -> String:
	return left._to_string() + " or " + right._to_string()


func get_left() -> Lottery:
	return left


func get_right() -> Lottery:
	return right


func set_left(l: Lottery):
	left = l


func set_right(r: Lottery):
	right = r
