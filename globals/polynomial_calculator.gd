extends Node
class_name Polynomials_calculator


#function used to create polynomial coeficients from weights
static func create_polynomial(weights: Array[float]) -> Array[float]:
	var coefs: Array[float] = []

	for i in range(len(weights)):
		coefs.append(create_nth_coef(weights, i))

	coefs.append(0.0)
	#print("Polynomial coefs are: ", coefs)
	return coefs


#a func to create nth coefficient
#args:
#weights - list of weigths
#n - ...
static func create_nth_coef(weights: Array[float], n: int) -> float:
	if n > len(weights):
		assert(false, "not the correct n")

	if n == len(weights)-1:
		return sum(weights) - 1

	if n == 0:
		return product(weights)

	var arrs: Array = arrays_without_n(weights,len(weights) - n)
	#print(arrs)
	for j in range(len(arrs)):
			arrs[j] = product(arrs[j])

	#print(arrs)
	return sum(arrs)


static func to_binary(intValue: int, bin_len: int) -> String:
	var bin_str: String = ""

	while intValue > 0:
		bin_str = str(intValue & 1) + bin_str
		intValue = intValue >> 1

	while len(bin_str) != bin_len:
		bin_str = "0" + bin_str

	return bin_str


#generate combinations:
static func arrays_without_n(arr: Array, n: int) -> Array:
	var all_combs = []

	for i in range(2**len(arr)):
		var bin_str = to_binary(i,len(arr)).split("")

		if bin_str.count("1") != n:

			continue

		#print(bin_str)
		var new_comb: Array = []

		for j in range(len(bin_str)):
			if bin_str[j] == "1":
				new_comb.append(arr[j])

		if len(new_comb) > 0:
			all_combs.append(new_comb)

	return all_combs


static func generate_variant(ctierion_array: Array[AssessCriterion]) -> Dictionary[AssessCriterion, float]:
	var variant: Dictionary[AssessCriterion, float] = {}

	for criterion in ctierion_array:
		var value: float = randf_range(criterion.point_list[0].x, criterion.point_list[-1].x)
		variant[criterion] = value

	return variant


#calculates u(x)
static func calculate_partial_usefullness(u_graph: Array[Vector2], value: float) -> float:
	var graph = u_graph.duplicate()
	var left_index: int = 0
	var right_index: int = len(graph) - 1

	var is_falling: bool = (graph[left_index].x > graph[right_index].x)

	#if value is below minimum or above maximum
	if max(graph[left_index].x, graph[right_index].x) < value or\
	 min(graph[left_index].x, graph[right_index].x) > value:
		return -12

	if is_falling:
		graph.reverse()

	while abs(left_index - right_index) != 1:
		var middle_index = int(left_index + floor(float(right_index - left_index)/2))

		if graph[middle_index].x < value:
			left_index = middle_index
		elif graph[middle_index].x > value:
			right_index = middle_index
		else:
			return graph[middle_index].y

	var t = (value - graph[left_index].x) / (graph[right_index].x - graph[left_index].x)
	return graph[left_index].y * (1-t) + graph[right_index].y * t


#calculates U(x)
static func calculate_global_usefullness(K: float, variant: Dictionary[AssessCriterion, float]):
	var p: float = 1.0

	for key in variant:
		p *= (K * key.weight * calculate_partial_usefullness(key.point_list, variant[key]) + 1)

	return(1/K) * (p - 1)


#sums elements of an array
static func sum(arr: Array) -> float:
	var s: float = 0

	for x in arr:
		s += x

	return s


# multiplies elements of an array
static func product(arr: Array) -> float:
	var p: float = 1

	for x in arr:
		p *= x

	return p


static func bairstow(coeffs: Array[float], max_iter: int=100, eps: float=1e-12) -> Array:
	var n = len(coeffs) - 1
	var roots = []
	var p = -1.0
	var q = -1.0
	var dq = 0
	var b = coeffs.duplicate()

	while n > 0:
		if n==1:
			roots.append(-b[1]/b[0])
			n=0
		elif n==2:
			p=b[1]/b[0]
			q=b[2]/b[0]
			n=0
		else:
			# do sprawdzania poprawek w iteracji
			var pq_err = [1e63, 1e63]

			for i in range(max_iter):
				# dla jasnosci:
				# q to zmienne pomocnicze przy dzieleniu
				# dq dp to pochodne do poprawek
				var q0 = 0.0
				var q1 = 0.0
				var q2 = b[0]
				var q3 = b[1] - p * b[0]

				for k in range(2, n + 1):
					var q4 = b[k] - p*q3 - q*q2
					dq = q2 - p*q1 - q*q0
					q0 = q1
					q1 = dq
					q2 = q3
					q3 = q4

				var det = q1 * q1 + (q * q0 + p * q1) * q0

				if abs(det)<1e-18:
					break

				var dp = (q1 * q2 - q0 * q3) / det
				dq = ((q * q0 + p * q1) * q2 + q1 * q3) / det

				if abs(dp) < eps and abs(dq) < eps:
					p+=dp
					q+=dq
					break

				if abs(dp) < pq_err[0] or abs(dq) < pq_err[1]:
					p = p+dp
					q = q+dq
					pq_err = [abs(dp), abs(dq)]
				else:
					break

			var new_b = [b[0]]

			if n>2:
				new_b.append(b[1] - p * b[0])
				for k in range(2, n - 1):
					new_b.append(b[k] - p * new_b[k-1] - q * new_b[k-2])

			b = new_b
			n = n - 2

		if n >= 0:
			var d = p*p - 4*q
			roots.append((-p+sqrt(d))/2)
			roots.append((-p-sqrt(d))/2)

	roots.resize(coeffs.size() - 1)
	return roots


func _ready():
	#var x: Array[float] = [1,2,3,4]
	#%weigths.text ="weights: " + " , ".join(x)
#
	#var poly: Array = create_polynomial(x)
	#%coefs.text ="coefs: " + " , ".join(poly)

	#var dividend: Array[float] = [6,5,2,4,5]
	#var divisor: Array[float] = [2,1,3]
	#%result.text = "result: " + str(polydiv(dividend, divisor))

	var barszczow: Array[float] = [1, -10, 35, -50, 24]

	%result.text = "result: " + " , ".join(bairstow(barszczow))

	#var t: Array[Vector2] = [Vector2(10.0, 0.0), Vector2(6.0, 0.2),Vector2(2.0, 0.6),Vector2(1.0, 0.7),Vector2(0.0, 1.0)]

	#%weigths.text = str(calculate_partial_usefullness(t,5.0))
