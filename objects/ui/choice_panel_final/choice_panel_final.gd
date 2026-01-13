extends Control
class_name ChoicePanelFinal
@export var variants: Array[Dictionary]
@export var K: float


func _ready() -> void:
	%Grid.columns = int(len(variants)/floor(2))
	variants.sort_custom(func(v): return Polynomials_calculator.calculate_global_usefullness(K, v))
	for i in range(len(variants)):
		%Grid.add_child(initialize_variant(variants[i], i))


func initialize_variant(v: Dictionary[AssessCriterion, float], rank: int) -> ChoicePanelFinalCard:
	var x = ChoicePanelFinalCard.new()
	x.rank = rank + 1
	x.variant = v
	return x
