extends Node2D
class_name objectMgr

const OBJ_SETTINGS_PANEL: String = "uid://d2xe4jjrkjnh0"
const OBJ_VOLUME_SLIDER: String = "uid://cn1bd1qg3n8ff"
const OBJ_CHOICE_PANEL: String = "uid://bgiawodt7wvts"
const OBJ_CHART_VISUALIZER: String = "uid://chw3reglhg6by"
const OBJ_END_SCREEN: String = "uid://dbyunepcv1c3b"
const OBJ_PAUSE_MENU: String = "uid://ylrjujxuk8ve"

var _preloaded: Dictionary[String, PackedScene] = {
	OBJ_SETTINGS_PANEL: preload(OBJ_SETTINGS_PANEL),
	OBJ_VOLUME_SLIDER: preload(OBJ_VOLUME_SLIDER),
	OBJ_CHOICE_PANEL: preload(OBJ_CHOICE_PANEL),
	OBJ_CHART_VISUALIZER: preload(OBJ_CHART_VISUALIZER),
	OBJ_END_SCREEN: preload(OBJ_END_SCREEN),
	OBJ_PAUSE_MENU: preload(OBJ_PAUSE_MENU),
}


func instantiate(object: String) -> Node:
	return _preloaded[object].instantiate()
