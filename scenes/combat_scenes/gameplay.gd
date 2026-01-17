extends Node2D

var game_time: float = 0.0


func _process(delta: float) -> void:
	game_time += delta
	GlobalInfo.game_time = game_time
