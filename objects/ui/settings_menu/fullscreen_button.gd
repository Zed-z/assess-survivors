extends CheckButton


func fullscreen_changed(fullscreen: bool) -> void:
	set_pressed_no_signal(fullscreen)


func _ready() -> void:
	ScreenManager.fullscreen_changed.connect(fullscreen_changed)
	fullscreen_changed(ScreenManager.get_fullscreen())


func _toggled(toggled_on: bool) -> void:
	ScreenManager.set_fullscreen(toggled_on)
	SettingsManager.set_setting("video/fullscreen", toggled_on)
