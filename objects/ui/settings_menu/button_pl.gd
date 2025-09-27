extends Button


func _on_pressed() -> void:
	TranslationServer.set_locale("pl")
	SettingsManager.set_setting("language", "pl")
