extends Node2D

var default_settings: Dictionary = {
	"audio": {
		"volume_Master": 1.0,
		"volume_Music": 1.0,
		"volume_Effects": 1.0,
	},
	"video": {
		"fullscreen": false,
		"screen_shake": true,
	},
	"language": OS.get_locale_language(),
	"popup": {
		"choice_criterion": false,
		"choice_weight": false,
		"choice_final": false,
	}
}

var settings = default_settings.copy()


func from_json(data: Dictionary, path_prefix: String = ""):

	default_settings.copy()

	for key in data:
		var key_path = path_prefix + key
		var val = data.get(key)

		if val is Dictionary:
			from_json(val, key_path + "/")
		else:
			if setting_exists(key_path):
				set_setting(key_path, val, false)


func to_json():
	return JSON.stringify(settings)


func setting_exists(path: String) -> bool:
	var path_array: PackedStringArray = path.split("/")
	var key = settings

	for p in path_array.slice(0, -1):
		if not key.has(p):
			return false

		key = key.get(p)

	return true


func set_setting(path: String, value: Variant, _save: bool = true) -> void:
	var path_array: PackedStringArray = path.split("/")
	var key = settings

	for p in path_array.slice(0, -1):
		key = key.get(p)

	key.set(path_array[-1], value)

	if _save:
		save()


func get_setting(path: String) -> Variant:
	var path_array: PackedStringArray = path.split("/")
	var key = settings

	for p in path_array:
		key = key.get(p)

	return key


func reset_setting(path: String) -> void:
	ersdfghjkl


func save(path: String = "user://settings.json"):
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_line(to_json())


func load_settings(path: String = "user://settings.json"):

	if not FileAccess.file_exists(path):
		return

	var file := FileAccess.open(path, FileAccess.READ)
	var data = JSON.parse_string(file.get_line())
	from_json(data)


func _init() -> void:
	load_settings()


func _ready() -> void:

	for bus in ["Master", "Music", "Effects"]:
		AudioManager.set_volume(bus, get_setting("audio/volume_" + bus))

	ScreenManager.set_fullscreen(get_setting("video/fullscreen"))

	TranslationServer.set_locale(get_setting("language"))
