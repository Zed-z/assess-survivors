extends Control
class_name ChoicePanelFinal
@export var variants: Array[Dictionary]
@export var K: float


func _ready() -> void:
	PauseManager.pause()
	%Grid.columns = int(len(variants)/floor(2))
	variants.sort_custom(func(v1,v2): return Polynomials_calculator.calculate_global_usefullness(K, v1) < Polynomials_calculator.calculate_global_usefullness(K, v2))
	for i in range(len(variants)):
		%Grid.add_child(initialize_variant(variants[i], i))


func initialize_variant(v: Dictionary[AssessCriterion, float], rank: int) -> ChoicePanelFinalCard:
	var x: ChoicePanelFinalCard = ObjectManager.instantiate(ObjectManager.OBJ_FINAL_CARD)

	x.rank = rank + 1
	x.variant = v
	x.variant_chosen.connect(chosen)
	return x


func chosen(variant: Dictionary[AssessCriterion, float], rank: int):
	$Timer.start()
	print(rank)
	for x in %Grid.get_children():
		x.disabled = true

	for c in variant:
		c.value_result.emit(variant[c])


func _on_timer_timeout() -> void:
	queue_free()


func _exit_tree() -> void:
	PauseManager.unpause()
