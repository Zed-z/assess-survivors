extends Button


func _on_pressed() -> void:
	TranslationServer.set_locale("de")
	SettingsManager.set_setting("language", "de")
