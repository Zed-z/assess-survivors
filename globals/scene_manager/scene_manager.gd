extends Node2D
class_name SceneMgr

var uids: Dictionary[String, String] = {
	"init": "uid://cksd53ocdjjc5",
	"main_menu": "uid://d1sq1okbpyorw",
	"assess_test": "uid://cd2dgvodr3u8k",
	"gameplay": "uid://fnao1rs5haap",
	"choice_menu": "uid://bgiawodt7wvts",
}

var current_scene: String = uids.keys()[0]
var next_scene: String = ""
var currently_loading: bool = false


func change_scene(
	scene: String
) -> void:
	next_scene = scene
	ResourceLoader.load_threaded_request(uids[next_scene])
	%SceneTransition/AnimationPlayer.play("fade_out")


func _on_scene_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().paused = true
		currently_loading = true


func _physics_process(_delta: float) -> void:
	if currently_loading:
		var status := ResourceLoader.load_threaded_get_status(uids[next_scene])

		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var scene: PackedScene = ResourceLoader.load_threaded_get(uids[next_scene])
			get_tree().change_scene_to_packed(scene)
			%SceneTransition/AnimationPlayer.play("fade_in")
			current_scene = next_scene
			next_scene = ""
			get_tree().paused = false
			currently_loading = false
