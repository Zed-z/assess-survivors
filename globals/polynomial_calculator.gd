extends Node
#function used to create polynomial coeficients from weights
func create_polynomial(weights: Array[float]) -> Array[float]:
	var coefs: Array[float] = []

	for i in range(len(weights)):
		print("coef %d th" % i)
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

	var arrs: Array = arrays_without_n(weights,n+1)
	print(arrs)
	for j in range(len(arrs)):
			arrs[j] = product(arrs[j])

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
		p*= x

	return p


func _ready():
	var x: Array[float] = [1,2,3,4]
	%weigths.text ="weights: " + " , ".join(x)
	var poly: Array = create_polynomial(x)
	%coefs.text ="coefs: " + " , ".join(poly)
