extends Control
class_name GameTypePopup

signal closed()


func _on_button_quick_game_pressed() -> void:
	GlobalInfo.game_type = GlobalInfo.GameType.Quick
	queue_free()
	closed.emit()


func _on_button_normal_game_pressed() -> void:
	GlobalInfo.game_type = GlobalInfo.GameType.Normal
	queue_free()
	closed.emit()
