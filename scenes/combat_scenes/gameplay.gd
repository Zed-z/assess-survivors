extends Node2D
class_name GameplayScene

var game_time: float = 0.0


func _ready() -> void:
	GlobalInfo.gameplay_scene = self


func _process(delta: float) -> void:
	game_time += delta
	GlobalInfo.game_time = game_time


func game_end():
	var end_screen: EndScreen = ObjectManager.instantiate(ObjectManager.OBJ_END_SCREEN)
	GlobalInfo.combat_ui_overlay.add_child(end_screen)
