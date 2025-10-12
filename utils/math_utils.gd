class_name MathUtils


## chooses one element with asumption that probability of all elements in aray sum up to one
static func choices_1f(data: Array[float])->int:
	var f = randf_range(0,1)

	for i in range(data.size()):
		f-= data[i]

		if f < 0:
			return i

	return data.size()-1
