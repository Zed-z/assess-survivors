extends Button


func _on_pressed() -> void:
	TranslationServer.set_locale("en")
	SettingsManager.set_setting("language", "en")
