extends Node
#function used to create polynomial coeficients from weights
func create_polynomial(weights: Array[float]) -> Array[float]:
	var coefs: Array[float] = []

	for i in range(len(weights)):
		coefs.append(create_nth_coef(weights, i))

	coefs.append(0.0)
	return coefs


#a func to create nth coefficient
#args:
#weights - list of weigths
#n - ...
func create_nth_coef(weights: Array[float], n: int) -> float:
	if n > len(weights):
		assert(false, "not the correct n")

	if n == len(weights)-1:
		return sum(weights) - 1

	if n == 0:
		return product(weights)

	var arrs: Array = arrays_without_n(weights,len(weights) - n)
	print(arrs)
	for j in range(len(arrs)):
			arrs[j] = product(arrs[j])

	print(arrs)
	return sum(arrs)


func to_binary(intValue: int, bin_len: int) -> String:
	var bin_str: String = ""

	while intValue > 0:
		bin_str = str(intValue & 1) + bin_str
		intValue = intValue >> 1

	while len(bin_str) != bin_len:
		bin_str = "0" + bin_str

	return bin_str


#generate combinations:
func arrays_without_n(arr: Array, n: int) -> Array:
	var all_combs = []

	for i in range(2**len(arr)):
		var bin_str = to_binary(i,len(arr)).split("")

		if bin_str.count("1") != n:

			continue

		print(bin_str)
		var new_comb: Array = []

		for j in range(len(bin_str)):
			if bin_str[j] == "1":
				new_comb.append(arr[j])

		if len(new_comb) > 0:
			all_combs.append(new_comb)

	return all_combs


func generate_variant(ctierion_array: Array[AssessCriterion]) -> Dictionary[AssessCriterion, float]:
	var variant: Dictionary[AssessCriterion, float] = {}

	for criterion in ctierion_array:
		var value: float = randf_range(criterion.point_list[0].x, criterion.point_list[-1].x)
		variant[criterion] = value

	return variant


#calculates u(x)
func calculate_partial_usefullness(criterion: AssessCriterion, value: float) -> float:
	var points: Array[Vector2] = criterion.point_list
	var left_index: int = 0
	var right_index: int = len(points) - 1

	var is_falling: bool = (points[left_index].x > points[right_index].x)

	#if value is below minimum or above maximum
	if max(points[left_index].x, points[right_index].x) < value or\
	 min(points[left_index].x, points[right_index].x) > value:
		return -12

	if is_falling:
		pass
	else:
		pass

	return 1.0


#calculates U(x)
func calculate_global_usefullness(K: float, variant: Dictionary[AssessCriterion, float]):
	var p: float = 1.0

	for key in variant:
		p *= (K * key.weight * calculate_partial_usefullness(key, variant[key]) + 1)

	return(1/K) * (p - 1)


#sums elements of an array
func sum(arr: Array) -> float:
	var s: float = 0

	for x in arr:
		s += x

	return s


# multiplies elements of an array
func product(arr: Array) -> float:
	var p: float = 1

	for x in arr:
		p *= x

	return p


func bairstow():
	pass


func polydiv(dividend: Array[float], divisor: Array[float]) -> Array[Array]:
	dividend = dividend.duplicate()
	divisor = divisor.duplicate()
	var lead_coeff = 0
	var deg_dividend = dividend.size() - 1
	var deg_divisor = divisor.size() - 1
	var quotient = []

	for i in range(deg_dividend-deg_divisor+1):
		quotient.append(0)

	while dividend.size() >= divisor.size():
		lead_coeff = dividend[0]/divisor[0]
		quotient[dividend.size()-divisor.size()] = lead_coeff

		for i in range(divisor.size()):
			dividend[i] -= lead_coeff * divisor[i]

		while dividend.size() > 0 and abs(dividend[0]) < 1e-10:
			dividend.remove_at(0)

	quotient.reverse()
	return [quotient, dividend]


func _ready():
	var x: Array[float] = [1,2,3,4]
	var dividend: Array[float] = [6,5,2,4,5]
	var divisor: Array[float] = [2,1,3]
	%weigths.text ="weights: " + " , ".join(x)
	var poly: Array = create_polynomial(x)
	%coefs.text ="coefs: " + " , ".join(poly)
	%result.text = "result: " + str(polydiv(dividend, divisor))
