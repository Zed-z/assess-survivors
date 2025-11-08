extends Control
class_name ChoicePanel

var criterion: AssessCriterion
var question: Question

var tween_left: Tween
var tween_right: Tween
var tween_indifferent: Tween
var tween_or: Tween


func _ready() -> void:
	get_tree().paused = true

	if question == null:
		queue_free()
		return

	%ChoiceLeft.setup(criterion, question.get_left())
	%ChoiceLeft.chosen.connect(_on_button_choose_left_pressed)
	%ChoiceRight.setup(criterion, question.get_right())
	%ChoiceRight.chosen.connect(_on_button_choose_right_pressed)

	%ButtonChooseNone.text = tr("CHOICE_PANEL_NONE")
	%LabelName.text = tr(criterion.criterion_name)


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:
	disable_controls()
	criterion.step(AssessCriterion.Answer.p)

	%ChoiceLeft.lottery_roll_speed = PI/10

	move_to_node(%ChoiceLeft, %ChoiceFinalPosition, tween_left)
	move_to_node(%ChoiceRight, %ChoiceOffscreen, tween_right)
	move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_button_choose_right_pressed() -> void:
	disable_controls()
	criterion.step(AssessCriterion.Answer.q)

	%ChoiceRight.lottery_roll_speed = PI/10

	move_to_node(%ChoiceRight, %ChoiceFinalPosition, tween_right)
	move_to_node(%ChoiceLeft, %ChoiceOffscreen, tween_left)
	move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
	move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_button_choose_none_pressed() -> void:
	disable_controls()
	var answer: AssessCriterion.StepAnswer = criterion.step(AssessCriterion.Answer.i)

	if answer.answer == AssessCriterion.Answer.p:
		move_to_node(%ChoiceLeft, %ChoiceFinalPosition, tween_left)
		move_to_node(%ChoiceRight, %ChoiceOffscreen, tween_right)
		move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
		move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)
	else:
		move_to_node(%ChoiceRight, %ChoiceFinalPosition, tween_right)
		move_to_node(%ChoiceLeft, %ChoiceOffscreen, tween_left)
		move_to_node(%ButtonChooseNone, %ChoiceOffscreen, tween_indifferent)
		move_to_node(%LabelOr, %ChoiceOffscreen, tween_or)

	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()


func disable_controls() -> void:
	%ChoiceLeft.disabled = true
	%ChoiceRight.disabled = true
	%ButtonChooseNone.disabled = true


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
