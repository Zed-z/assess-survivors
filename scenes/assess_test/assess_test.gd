extends Control


func _on_button_question_pressed() -> void:
	add_child(GlobalInfo.assess_manager.init_choice_panel())


func _on_button_weights_pressed() -> void:
	%ButtonWeights.disabled = true
	GlobalInfo.assess_manager.next_phase()
