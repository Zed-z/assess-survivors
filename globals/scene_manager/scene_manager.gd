extends Node2D
class_name SceneMgr

var uids: Dictionary[String, String] = {
	"main_menu": "uid://d1sq1okbpyorw",
	"assess_test": "uid://cd2dgvodr3u8k",
	"test_scene": "uid://fnao1rs5haap",

	"settings_panel": "uid://d2xe4jjrkjnh0",
	"volume_slider": "uid://cn1bd1qg3n8ff",
}

var current_scene: String = uids.keys()[0]
var next_scene: String = ""


func change_scene(
	scene: String
) -> void:
	next_scene = scene
	%SceneTransition/AnimationPlayer.play("fade_out")


func _on_scene_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		current_scene = next_scene
		var uid := uids[current_scene]
		get_tree().change_scene_to_file(uid)
		%SceneTransition/AnimationPlayer.play("fade_in")
