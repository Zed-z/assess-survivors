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


func bairstow(coeffs: Array[float], max_iter: int=100) -> Array[float]:
	coeffs = coeffs.duplicate()
	var roots: Array[float] = []
	var g: int = len(roots) - 1

	while len(coeffs) > 0:
		if len(coeffs) == 1: # no roots here
			break
		elif len(coeffs) == 2: # linear 
			var root: float = -coeffs[1]/coeffs[0]
			roots.append(root)
			break
		elif len(coeffs) == 3: # quadratic
			var a = coeffs[0]
			var b = coeffs[1]
			var c = coeffs[2]
			var D = b**2 - 4*a*c

			if D < 0:
				break

			var root1 = (-b + sqrt(D)) / (2*a)
			var root2 = (-b - sqrt(D)) / (2*a)
			roots.append_array([root1, root2])
			break
		else:

			var an = coeffs[g]
			var an_1 = coeffs[g-1]
			var an_2 = coeffs[g-2]
			var u = an_1 / an # initial guesses could be random as well but this should lead faster to convergence
			var v = an_2 / an

			# divide polynomial by x^2 + ux + v
			for iter in range(max_iter):
				var ret = polydiv(coeffs, [1,u,v])# quotient and remainder
				var quot = ret[0]
				var rem = ret[1]

				while len(rem) < 2: #TODO: napewno są lepsze alternatywy
					rem.push_front(0)

				var A = rem[-2]
				var B = rem[-1]
				var b = quot

				while len(b) < len(coeffs)-1:
					b = [0] + b

				# jacobian matrix equivalent i think
				var c2 = b[0]
				var c1 = b[1] + u*c2
				var c0 = b[2] + u*c1 + v*c2
				var denom_jacob = c1**2 - c0*c2 # jacobian denominator
				# newton iteration step
				if abs(denom_jacob) < 1e-14:
					denom_jacob = 1e-14 # avoid division by zero

				var du = (A*c1 - B*c2) / denom_jacob
				var dv = (B*c0 - A*c1) / denom_jacob

				# correct the guessess
				u -= du
				v -= dv

				if abs(A) < 1e-12 and abs(B) < 1e-12:
					break

			var D = u**2 - 4*v # delta
			var x1 = (-u + sqrt(D)) / 2 # new roots
			var x2 = (-u - sqrt(D)) / 2
			roots.append_array([x1, x2])

			coeffs = polydiv(coeffs, [1, u, v])[0]

			while coeffs[0] == 0:
				coeffs.pop_front() # so the degree actually decreases

		if len(coeffs) == 2:
			roots.append(-coeffs[1]/coeffs[0])

	return roots


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
	#var x: Array[float] = [1,2,3,4]
	#%weigths.text ="weights: " + " , ".join(x)

	#var poly: Array = create_polynomial(x)
	#%coefs.text ="coefs: " + " , ".join(poly)

	#var dividend: Array[float] = [6,5,2,4,5]
	#var divisor: Array[float] = [2,1,3]
	#%result.text = "result: " + str(polydiv(dividend, divisor))

	var barszczow: Array[float] = [-4, 6, 2,0]
	%result.text = "result: " + " , ".join(bairstow(barszczow))
