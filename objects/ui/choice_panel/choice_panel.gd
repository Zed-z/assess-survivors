extends Control
class_name ChoicePanel

var choice_single: PackedScene = preload("res://objects/ui/choice_panel/choice_panel_choice.tscn")
var choice_multi: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_choice_weight.tscn")

var criterion: AssessCriterion
var question: Question
var is_weight_phase: bool
var tween_left: Tween
var tween_right: Tween
var tween_indifferent: Tween
var tween_or: Tween


func _ready() -> void:
	get_tree().paused = true

	if question == null:
		queue_free()
		return

	is_weight_phase = ! question.get_left() is SingleLottery

	if !is_weight_phase:
		var left = choice_single.instantiate()
		left.setup(criterion, question.get_left())
		left.chosen.connect(_on_button_choose_left_pressed)
		%ChoiceLeftContainer.add_child(left)
	else:
		var left = choice_multi.instantiate()
		left.setup(criterion, question.get_left())
		left.chosen.connect(_on_button_choose_left_pressed)
		%ChoiceLeftContainer.add_child(left)

	if !is_weight_phase:
		var right = choice_single.instantiate()
		right.setup(criterion, question.get_right())
		right.chosen.connect(_on_button_choose_left_pressed)
		%ChoiceRightContainer.add_child(right)
	else:
		var right = choice_multi.instantiate()
		right.setup(criterion, question.get_right())
		right.chosen.connect(_on_button_choose_left_pressed)
		%ChoiceRightContainer.add_child(right)

	#%ChoiceLeft.setup(criterion, question.get_left())
	#%ChoiceLeft.chosen.connect(_on_button_choose_left_pressed)
	#%ChoiceRight.setup(criterion, question.get_right())
	#%ChoiceRight.chosen.connect(_on_button_choose_right_pressed)

	%ButtonChooseNone.text = tr("CHOICE_PANEL_NONE")
	%LabelName.text = tr(criterion.criterion_name)


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:
	disable_controls()
	if !is_weight_phase:
		criterion.step(AssessCriterion.Answer.p)
	else:
		GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.p)

	#%ChoiceLeft.lottery_roll_speed = PI/10
#
	#move_to_node(%ChoiceLeft, %ChoiceFinalPosition, tween_left)
	#move_to_node(%ChoiceRight, %ChoiceOffscreen, tween_right)
	#move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	#move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_button_choose_right_pressed() -> void:
	disable_controls()
	if !is_weight_phase:
		criterion.step(AssessCriterion.Answer.q)
	else:
		GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.q)

	#%ChoiceRight.lottery_roll_speed = PI/10
#
	#move_to_node(%ChoiceRight, %ChoiceFinalPosition, tween_right)
	#move_to_node(%ChoiceLeft, %ChoiceOffscreen, tween_left)
	#move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	#move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_button_choose_none_pressed() -> void:
	disable_controls()
	if !is_weight_phase:
		var answer: AssessCriterion.StepAnswer = criterion.step(AssessCriterion.Answer.i)
	else:
		GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.i)

	#if answer.answer == AssessCriterion.Answer.p:
		#move_to_node(%ChoiceLeft, %ChoiceFinalPosition, tween_left)
		#move_to_node(%ChoiceRight, %ChoiceOffscreen, tween_right)
		#move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
		#move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	#else:
		#move_to_node(%ChoiceRight, %ChoiceFinalPosition, tween_right)
		#move_to_node(%ChoiceLeft, %ChoiceOffscreen, tween_left)
		#move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
		#move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()


func disable_controls() -> void:
	pass
	#%ChoiceLeft.disabled = true
	#%ChoiceRight.disabled = true
	#%ButtonChooseNone.disabled = true


func move_to_node(node: Control, target: Control, tween: Tween):
	if (tween):
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(
		node,
		"position",
		target.position - node.size / 2,
		0.25)

	tween.play()
