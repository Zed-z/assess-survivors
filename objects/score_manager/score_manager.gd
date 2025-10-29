extends Node2D
class_name ScoreManager

signal score_changed(score: int)
var score: int:
	set(val):
		score = val
		score_changed.emit(score)


func _ready() -> void:
	GlobalInfo.score_manager = self
	score_reset()


func score_reset() -> void:
	score = 0


func score_increase(amount: int) -> void:
	score += amount
