extends Control

func _ready() -> void:
	$Button.grab_focus()

func _on_settings_button_pressed() -> void:
	var settings = load("res://scenes/settings_menu/settings_menu.tscn")
	var s = settings.instantiate()
	s.close_callback = func():
		$SettingsButton.grab_focus()
	get_parent().add_child(s)
