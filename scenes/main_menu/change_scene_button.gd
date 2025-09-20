extends Button

@export var scene: String


func _pressed() -> void:
	SceneManager.change_scene(scene)
