extends CheckButton


func _ready() -> void:
	button_pressed = SettingsManager.get_setting("video/enemy_health_bars")


func _toggled(toggled_on: bool) -> void:
	SettingsManager.set_setting("video/enemy_health_bars", toggled_on)
