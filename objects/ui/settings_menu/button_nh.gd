extends Button


func _on_pressed() -> void:
	TranslationServer.set_locale("nh")
	SettingsManager.set_setting("language", "nh")
