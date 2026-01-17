extends Control


func _ready() -> void:
	PauseManager.pause()
	$SoundOpenClose.play()


func close() -> void:
	visible = false
	PauseManager.unpause()
	$SoundOpenClose.play()
	await $SoundOpenClose.finished
	queue_free()


func _on_button_continue_pressed() -> void:
	close()


func _on_button_settings_pressed() -> void:
	var s = ObjectManager.instantiate(ObjectManager.OBJ_SETTINGS_PANEL)
	get_parent().add_child(s)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close()


func _on_button_assess_info_pressed() -> void:
	var s: AssessInfoPanel = ObjectManager.instantiate(ObjectManager.OBJ_ASSESS_INFO_PANEL)
	s.assess_manager = GlobalInfo.assess_manager
	get_parent().add_child(s)
