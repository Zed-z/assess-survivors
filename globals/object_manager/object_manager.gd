extends Node2D
class_name objectMgr

const OBJ_SETTINGS_PANEL: String = "uid://d2xe4jjrkjnh0"
const OBJ_VOLUME_SLIDER: String = "uid://cn1bd1qg3n8ff"
const OBJ_CHOICE_PANEL: String = "uid://bgiawodt7wvts"
const OBJ_CHART_VISUALIZER: String = "uid://chw3reglhg6by"
const OBJ_END_SCREEN: String = "uid://dbyunepcv1c3b"
const OBJ_PAUSE_MENU: String = "uid://ylrjujxuk8ve"
const OBJ_ASSESS_INFO: String = "uid://cu78d8juxtctw"
const OBJ_ASSESS_INFO_PANEL: String = "uid://bx0v4ik3jf2f7"
const OBJ_GAME_TYPE_POPUP: String = "uid://dnmihxjpuf5ix"
const OBJ_FINAL_PANEL: String = "uid://dfkubp0nme5xb"
const OBJ_FINAL_CARD: String = "uid://dcfbmk7lea3yd"

var _preloaded: Dictionary[String, PackedScene] = {
	OBJ_SETTINGS_PANEL: preload(OBJ_SETTINGS_PANEL),
	OBJ_VOLUME_SLIDER: preload(OBJ_VOLUME_SLIDER),
	OBJ_CHOICE_PANEL: preload(OBJ_CHOICE_PANEL),
	OBJ_CHART_VISUALIZER: preload(OBJ_CHART_VISUALIZER),
	OBJ_END_SCREEN: preload(OBJ_END_SCREEN),
	OBJ_PAUSE_MENU: preload(OBJ_PAUSE_MENU),
	OBJ_ASSESS_INFO: preload(OBJ_ASSESS_INFO),
	OBJ_ASSESS_INFO_PANEL: preload(OBJ_ASSESS_INFO_PANEL),
	OBJ_GAME_TYPE_POPUP: preload(OBJ_GAME_TYPE_POPUP),
	OBJ_FINAL_PANEL: preload(OBJ_FINAL_PANEL),
	OBJ_FINAL_CARD: preload(OBJ_FINAL_CARD)
}


func instantiate(object: String) -> Node:
	return _preloaded[object].instantiate()
