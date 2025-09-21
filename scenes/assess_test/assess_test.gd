extends Control


func update_text(_points: Array[Vector2]):
	%AssessQuestion.text = "%s   vs   %s" % [$AssessCriterion.get_left(), $AssessCriterion.get_right()]


func _ready() -> void:

	$AssessCriterion.points_changed.connect(%ChartVisualizer.set_points)
	$AssessCriterion.points_changed.connect(update_text)
	%ChartVisualizer.set_points($AssessCriterion.point_list)

	print($AssessCriterion.point_list)
	update_text([])


func _on_button_left_pressed() -> void:
	$AssessCriterion.step(AssessCriterion.Answer.p)
	print($AssessCriterion.point_list)


func _on_button_right_pressed() -> void:
	$AssessCriterion.step(AssessCriterion.Answer.q)
	print($AssessCriterion.point_list)


func _on_button_indifferent_pressed() -> void:
	$AssessCriterion.step(AssessCriterion.Answer.i)
	print($AssessCriterion.point_list)


func _on_button_scenario_pressed() -> void:
	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.q)
	$AssessCriterion.step(AssessCriterion.Answer.i)

	$AssessCriterion.step(AssessCriterion.Answer.p)
	$AssessCriterion.step(AssessCriterion.Answer.p)
	#step(Answer.i)

	print($AssessCriterion.point_list)
