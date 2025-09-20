extends Control


func _ready() -> void:
	$HBoxContainer/Button.grab_focus()


func _on_settings_button_pressed() -> void:
	var settings = load(SceneManager.uids["settings_panel"])
	var s = settings.instantiate()
	s.close_callback = func():
		$HBoxContainer/SettingsButton.grab_focus()

	get_parent().add_child(s)
