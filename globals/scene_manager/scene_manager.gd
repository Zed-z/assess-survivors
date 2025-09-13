extends Node2D
class_name SceneMgr

enum Scene {
	SettingsMenu,
	VolumeSlider,

	TestScene,
}

var uids: Dictionary[Scene, String] = {
	Scene.SettingsMenu: "uid://d2xe4jjrkjnh0",
	Scene.VolumeSlider: "uid://cn1bd1qg3n8ff",

	Scene.TestScene: "uid://fnao1rs5haap",
}


var next_scene: String = ""

func change_scene(
	scene: Scene
) -> void:
	var uid := uids[scene]
	next_scene = uid
	%SceneTransition/AnimationPlayer.play("fade_out")

func _on_scene_transition_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().change_scene_to_file(next_scene)
		%SceneTransition/AnimationPlayer.play("fade_in")
