extends Control


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_choose_left_pressed() -> void:

	queue_free()


func _on_button_choose_right_pressed() -> void:

	queue_free()
