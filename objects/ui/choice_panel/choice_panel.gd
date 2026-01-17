extends Control
class_name ChoicePanel

var choice_single: PackedScene = preload("res://objects/ui/choice_panel/choice_panel_choice.tscn")
var choice_multi: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_choice_weight.tscn")

var choice_left: ChoicePanelCard
var choice_right: ChoicePanelCard

var criterion: AssessCriterion
var question: Question
var phase: AssessManagerClass.GamePhases
var tween_left: Tween
var tween_right: Tween
var tween_indifferent: Tween
var tween_or: Tween


func _ready() -> void:
	PauseManager.pause()

	if question == null:
		queue_free()
		return

	if phase == AssessManagerClass.GamePhases.CRITERION:
		choice_left = choice_single.instantiate()
		choice_left.setup(criterion, question.get_left())
	else:
		choice_left = choice_multi.instantiate()
		choice_left.setup(criterion, question.get_left())

	choice_left.chosen.connect(_on_button_choose_left_pressed)
	%ChoiceLeftContainer.add_child(choice_left)

	if phase == AssessManagerClass.GamePhases.CRITERION:
		choice_right = choice_single.instantiate()
		choice_right.setup(criterion, question.get_right())
	else:
		choice_right = choice_multi.instantiate()
		choice_right.setup(criterion, question.get_right())

	choice_right.chosen.connect(_on_button_choose_right_pressed)
	%ChoiceRightContainer.add_child(choice_right)

	%LabelName.text = tr(criterion.criterion_name)


func _exit_tree() -> void:
	PauseManager.unpause()


func anim_choose_left(answer) -> void:
	move_to_node(choice_left, %ChoiceFinalPosition, tween_left)
	move_to_node(choice_right, %ChoiceOffscreen, tween_right)
	move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	choice_left.start_lottery_animation()
	await get_tree().create_timer(0.5).timeout
	choice_left.stop_lottery_animation(answer.value.win)

	if choice_left.choice.win_probability == 1:
		play_sound_safe()
	else:
		play_sound_lottery(answer.value.win)


func anim_choose_right(answer) -> void:
	move_to_node(choice_right, %ChoiceFinalPosition, tween_right)
	move_to_node(choice_left, %ChoiceOffscreen, tween_left)
	move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	choice_right.start_lottery_animation()
	await get_tree().create_timer(0.5).timeout
	choice_right.stop_lottery_animation(answer.value.win)

	if choice_right.choice.win_probability == 1:
		play_sound_safe()
	else:
		play_sound_lottery(answer.value.win)


func play_sound_safe():
	$SoundSafe.play()


func play_sound_lottery(win: bool):
	if win:
		$SoundLotteryWin.play()
	else:
		$SoundLotteryLose.play()


func _on_button_choose_left_pressed() -> void:
	disable_controls()

	var answer
	if phase == AssessManagerClass.GamePhases.CRITERION:
		answer = criterion.step(AssessCriterion.Answer.p)
	else:
		answer = GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.p)
#
	anim_choose_left(answer)
	$Timer.start()


func _on_button_choose_right_pressed() -> void:
	disable_controls()

	var answer
	if phase == AssessManagerClass.GamePhases.CRITERION:
		answer = criterion.step(AssessCriterion.Answer.q)
	else:
		answer = GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.q)
#
	anim_choose_right(answer)
	$Timer.start()


func _on_button_choose_none_pressed() -> void:
	disable_controls()

	var answer
	if phase == AssessManagerClass.GamePhases.CRITERION:
		answer = criterion.step(AssessCriterion.Answer.i)
	else:
		answer = GlobalInfo.assess_manager.weight_step(AssessCriterion.Answer.i)

	if answer.answer == AssessCriterion.Answer.p:
		anim_choose_left(answer)
	else:
		anim_choose_right(answer)

	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()


func disable_controls() -> void:
	choice_left.disabled = true
	choice_right.disabled = true
	%ButtonChooseNone.disabled = true


func move_to_node(node: Control, target: Control, tween: Tween):
	if (tween):
		tween.kill()

	tween = create_tween().set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(
		node,
		"global_position",
		target.global_position - node.size / 2,
		0.25)

	tween.play()
