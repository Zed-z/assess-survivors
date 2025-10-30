extends Button


func _on_pressed() -> void:
	TranslationServer.set_locale("ja")
	SettingsManager.set_setting("language", "ja")
