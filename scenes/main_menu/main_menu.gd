extends Control


func _ready() -> void:

	%ButtonPlay.grab_focus()

	match OS.get_name():
		"Windows", "Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			%ButtonQuit.visible = true

		_:
			%ButtonQuit.visible = false


func _on_settings_button_pressed() -> void:
	var s = ObjectManager.instantiate(ObjectManager.OBJ_SETTINGS_PANEL)
	s.close_callback = func():
		%SettingsButton.grab_focus()

	get_parent().add_child(s)


func _on_button_quit_pressed() -> void:
	get_tree().quit()


func _on_button_play_pressed() -> void:
	var p: GameTypePopup = ObjectManager.instantiate(ObjectManager.OBJ_GAME_TYPE_POPUP)
	get_parent().add_child(p)
	await p.closed
	SceneManager.change_scene("gameplay")
