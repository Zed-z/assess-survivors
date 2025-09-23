extends Control


func update_text(question: Array[Lottery]):
	%AssessQuestion.text = "%s   vs   %s" % [question[0], question[1]]


func _ready() -> void:

	$AssessCriterion.points_changed.connect(%ChartVisualizer.set_points)
	%ChartVisualizer.set_points($AssessCriterion.point_list)

	$AssessCriterion.question_changed.connect(update_text)
	update_text($AssessCriterion.get_question())


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
