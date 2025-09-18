extends RefCounted
class_name SwapbackArray

var array: Array
var max_size: int
var size: int


func _init(new_size: int) -> void:
	array = Array()
	array.resize(new_size)
	max_size = new_size
	size = 0


func add_element(elem) -> bool:
	if size >= max_size:
		printerr("out of space in array")
		return false

	array[size] = elem
	size += 1
	return true


func erase(elem):
	for x in range(array.size()):
		if elem == array[x]:
			size -= 1
			var e = array[x]
			array[x] = array[size]
			array[size] = null
			return e


func remove_at(position):
	if position > size:
		printerr("tried to erase outside of array bounds")
		return null

	size -= 1
	var e = array[position]
	array[position] = array[size]
	array[size] = null
	return e
