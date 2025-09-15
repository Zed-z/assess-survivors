extends Node2D


class AudioBus:

	var bus_name: String
	var bus_index: int

	var volume: float:
		get:
			return volume
		set(_value):
			volume = _value
			AudioServer.set_bus_volume_linear(bus_index, _value)

	func _init(_bus_name: String):
		bus_name = _bus_name
		bus_index = AudioServer.get_bus_index(_bus_name)
		volume = 1.0


var audio_buses: Dictionary[String, AudioBus] = {}

func _ready() -> void:

	for bus in ["Master", "Music", "Effects"]:
		audio_buses[bus] = AudioBus.new(bus)


func get_volume(bus_name: String) -> float:
	return audio_buses[bus_name].volume

func set_volume(bus_name: String, volume: float) -> void:
	audio_buses[bus_name].volume = volume
