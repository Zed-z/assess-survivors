extends Control


func _ready() -> void:
	$HBoxContainer/Button.grab_focus()


func _on_settings_button_pressed() -> void:
	var s = ObjectManager.instantiate(ObjectManager.OBJ_SETTINGS_PANEL)
	s.close_callback = func():
		$HBoxContainer/SettingsButton.grab_focus()

	get_parent().add_child(s)
