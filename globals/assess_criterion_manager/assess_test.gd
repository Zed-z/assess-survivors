extends Control


func _ready() -> void:

	for criterion: AssessCriterion in $AssessManager.criteria:
		criterion.points_changed.connect(%ChartVisualizer.set_points)
		%ChartVisualizer.set_points(criterion.point_list)

	print($AssessManager.criteria[0].point_list)


func _on_button_left_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.p)
	print($AssessManager.criteria[0].point_list)


func _on_button_right_pressed() -> void:
	$AssessManager.criteria[0].step(AssessCriterion.Answer.q)
	print($AssessManager.criteria[0].point_list)


func _on_button_add_pressed() -> void:
	$AssessManager.criteria[0].do_point_append()
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
