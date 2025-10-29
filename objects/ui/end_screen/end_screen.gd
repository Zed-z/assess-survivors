extends Control
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true

	%LabelScore.text = tr("END_SCREEN_SCORE_COUNTER") % GlobalInfo.score_manager.score


func _exit_tree() -> void:
	get_tree().paused = false
