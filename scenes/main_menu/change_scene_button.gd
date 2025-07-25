extends Button


@export_file("*.tscn") var filepath : String


	
func _pressed() -> void:
	get_tree().change_scene_to_file(filepath)
