extends Button
class_name SceneChangeButton

@export var scene: String


func _pressed() -> void:
	SceneManager.change_scene(scene)
