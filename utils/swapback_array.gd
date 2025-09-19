extends RefCounted
class_name SwapbackArray

var array: Array
var array_clean: Array:
	get():
		return array.filter(func(x): return x != null)

	set(val):
		printerr("Do not say that again.")

var current_size: int
var size_increment: int = 10


func _init(new_size: int = 0,_size_increment: int = 10) -> void:
	array = Array()
	array.resize(new_size)
	current_size = 0
	size_increment = _size_increment


func at(index: int):
	if index >= current_size:
		printerr("out of band when accesing array")
		return null

	return array[index]


func _iter_init(iter):
	iter[0] = 0
	return iter[0] < current_size


func _iter_next(iter):
	iter[0] += 1
	return iter[0] < current_size


func _iter_get(iter):
	return array[iter]


func append(elem) -> bool:
	if current_size == array.size():
		array.resize(array.size() + size_increment)
		print("resized array new size %d" % array.size())

	array[current_size] = elem
	current_size += 1

	return true


func erase(elem):
	for x in range(current_size):
		if elem == array[x]:
			current_size -= 1
			var e = array[x]
			array[x] = array[current_size]
			array[current_size] = null
			return e

	return null


func size()->int:
	return array.size()


func remove_at(position):
	if position > current_size:
		printerr("tried to erase outside of array bounds")
		return null

	current_size -= 1
	var e = array[position]
	array[position] = array[current_size]
	array[current_size] = null
	return e
