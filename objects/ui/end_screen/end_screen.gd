extends Control
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true

	%LabelScore.text = "Score: " + "%08s" % GlobalInfo.score_manager.score


func _exit_tree() -> void:
	get_tree().paused = false
