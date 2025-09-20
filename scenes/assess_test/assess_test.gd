extends Control


func update_text(_points: Array[Vector2]):
	%AssessQuestion.text = "%s   vs   %s" % [$AssessManager.criteria[0].get_left(), $AssessManager.criteria[0].get_right()]


func _ready() -> void:

	for criterion: AssessCriterion in $AssessManager.criteria:
		criterion.points_changed.connect(%ChartVisualizer.set_points)
		criterion.points_changed.connect(update_text)
		%ChartVisualizer.set_points(criterion.point_list)

	print($AssessManager.criteria[0].point_list)
	update_text([])


func _on_button_left_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	print($AssessManager.criteria[0].point_list)


func _on_button_right_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	print($AssessManager.criteria[0].point_list)


func _on_button_indifferent_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)
	print($AssessManager.criteria[0].point_list)


func _on_button_scenario_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.i)

	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	#step(Answer.i)

	print($AssessManager.criteria[0].point_list)
