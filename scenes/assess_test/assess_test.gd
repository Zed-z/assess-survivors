extends Control


func set_phase_title() -> void:
	match GlobalInfo.assess_manager.phase:
		AssessManagerClass.GamePhases.CRITERION:
			%PhaseTitle.text = tr("PHASE_CRITERION")

		AssessManagerClass.GamePhases.WEIGHTS:
			%PhaseTitle.text = tr("PHASE_WEIGHT")

		AssessManagerClass.GamePhases.FINAL:
			%PhaseTitle.text = tr("PHASE_FINAL")


func _ready() -> void:
	set_phase_title()


func _on_button_question_pressed() -> void:
	add_child(GlobalInfo.assess_manager.init_choice_panel())


func _on_button_weights_pressed() -> void:
	GlobalInfo.assess_manager.next_phase()
	set_phase_title()
	%ButtonWeights.disabled = GlobalInfo.assess_manager.phase == AssessManagerClass.GamePhases.FINAL
