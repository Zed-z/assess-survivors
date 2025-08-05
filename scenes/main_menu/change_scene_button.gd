extends Button

@export var scene: SceneMgr.Scene

func _pressed() -> void:
	SceneManager.change_scene(scene)
