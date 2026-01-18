extends CheckButton


func _ready() -> void:
	button_pressed = SettingsManager.get_setting("tutorial_enabled")


func _toggled(toggled_on: bool) -> void:
	SettingsManager.set_setting("tutorial_enabled", toggled_on)
