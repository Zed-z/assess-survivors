extends Control
class_name EndScreen


func _ready() -> void:
	get_tree().paused = true

	%LabelScore.text = tr("END_SCREEN_SCORE_COUNTER") % GlobalInfo.score_manager.score


func _exit_tree() -> void:
	get_tree().paused = false


func _on_button_assess_info_pressed() -> void:
	var s: AssessInfoPanel = ObjectManager.instantiate(ObjectManager.OBJ_ASSESS_INFO_PANEL)
	s.assess_manager = GlobalInfo.assess_manager
	get_parent().add_child(s)
