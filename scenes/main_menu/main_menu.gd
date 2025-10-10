extends Control


func _ready() -> void:
	$HBoxContainer/Button.grab_focus()

	match OS.get_name():
		"Windows", "Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			$HBoxContainer/ButtonQuit.visible = true

		_:
			$HBoxContainer/ButtonQuit.visible = false


func _on_settings_button_pressed() -> void:
	var s = ObjectManager.instantiate(ObjectManager.OBJ_SETTINGS_PANEL)
	s.close_callback = func():
		$HBoxContainer/SettingsButton.grab_focus()

	get_parent().add_child(s)


func _on_button_quit_pressed() -> void:
	get_tree().quit()
