extends Node2D
class_name objectMgr

const OBJ_SETTINGS_PANEL: String = "uid://d2xe4jjrkjnh0"
const OBJ_VOLUME_SLIDER: String = "uid://cn1bd1qg3n8ff"
const OBJ_CHOICE_PANEL: String = "uid://bgiawodt7wvts"

var _preloaded: Dictionary[String, PackedScene] = {
	OBJ_SETTINGS_PANEL: preload(OBJ_SETTINGS_PANEL),
	OBJ_VOLUME_SLIDER: preload(OBJ_VOLUME_SLIDER),
	OBJ_CHOICE_PANEL: preload(OBJ_CHOICE_PANEL)
}


func instantiate(object: String) -> Node:
	return _preloaded[object].instantiate()
