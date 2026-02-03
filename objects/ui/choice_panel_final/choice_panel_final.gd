extends Control
class_name ChoicePanelFinal
@export var variants: Array[Dictionary]
@export var K: float
var choice_cards: Array[ChoicePanelFinalCard] = []


func _ready() -> void:
	PauseManager.pause()
	%Grid.columns = int(len(variants)/floor(2))
	#variants.sort_custom(func(v1,v2): return Polynomials_calculator.calculate_global_usefullness(K, v1) < Polynomials_calculator.calculate_global_usefullness(K, v2))
	for i in range(len(variants)):
		%Grid.add_child(initialize_variant(variants[i], i))


func initialize_variant(v: Dictionary[AssessCriterion, float], rank: int) -> ChoicePanelFinalCard:
	var x: ChoicePanelFinalCard = ObjectManager.instantiate(ObjectManager.OBJ_FINAL_CARD)
	x.rank = rank + 1
	x.utility = Polynomials_calculator.calculate_global_usefullness(K, v)
	x.variant = v
	x.variant_chosen.connect(chosen)
	choice_cards.append(x)
	return x


func chosen(variant: Dictionary[AssessCriterion, float], rank: int):

	$SoundChosen.play()
	$Timer.start()

	print(rank)
	for x: ChoicePanelFinalCard in %Grid.get_children():
		x.disabled = true

		if x.variant != variant:
			x.modulate = Color(0.5, 0.5, 0.5, 0.5)

	for c in variant:
		c.value_result.emit(variant[c])


func _on_timer_timeout() -> void:
	queue_free()


func _exit_tree() -> void:
	PauseManager.unpause()


func _input(event: InputEvent) -> void:
	for i in range(0, 10):
		if event.is_action_pressed("choose_%s" % (i + 1)):
			if i < choice_cards.size():
				chosen(choice_cards[i].variant, choice_cards[i].rank)
