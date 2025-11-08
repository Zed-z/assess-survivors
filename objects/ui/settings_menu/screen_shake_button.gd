extends CheckButton


func _ready() -> void:
	button_pressed = SettingsManager.get_setting("video/screen_shake")


func _toggled(toggled_on: bool) -> void:
	SettingsManager.set_setting("video/screen_shake", toggled_on)
