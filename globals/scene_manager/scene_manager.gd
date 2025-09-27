extends Node2D
class_name SceneMgr

var uids: Dictionary[String, String] = {
	"main_menu": "uid://d1sq1okbpyorw",
	"assess_test": "uid://cd2dgvodr3u8k",
	"test_scene": "uid://fnao1rs5haap",
	"choice_menu": "uid://bgiawodt7wvts",
}

var current_scene: String = uids.keys()[0]
var next_scene: String = ""

var load_ok: bool = false
var currently_loading: String = ""


func change_scene(
	scene: String
) -> void:
	currently_loading = uids[scene]
	ResourceLoader.load_threaded_request(currently_loading)
	%SceneTransition/AnimationPlayer.play("fade_out")


func _on_scene_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().paused = true
		load_ok = true


func _physics_process(_delta: float) -> void:
	if load_ok and ResourceLoader.load_threaded_get_status(currently_loading) == ResourceLoader.THREAD_LOAD_LOADED:
		var scene: PackedScene = ResourceLoader.load_threaded_get(currently_loading)
		get_tree().change_scene_to_packed(scene)
		%SceneTransition/AnimationPlayer.play("fade_in")
		get_tree().paused = false
		load_ok = false
