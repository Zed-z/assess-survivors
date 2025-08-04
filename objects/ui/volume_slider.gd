extends HSlider

@export_enum("Master", "Music", "Effects") var audio_bus: String

func _ready() -> void:
	print(audio_bus)
	value = AudioManager.get_volume(audio_bus)

func _on_value_changed(value: float) -> void:
	AudioManager.set_volume(audio_bus, value)
