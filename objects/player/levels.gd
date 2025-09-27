extends Node

var level: int =0
var required_xp: int = 0
var collected_xp: int = 0

signal new_level(level: int)


func _ready() -> void:
	set_new_required_ex(0)
	await get_tree().process_frame
	GlobalInfo.enemy_spawner.enemy_killed.connect(xp_collected)
	GlobalInfo.combat_ui_overlay.update_progres_bar(level, collected_xp,required_xp)


func set_new_required_ex(_new_level: int):
	required_xp = 10 * _new_level + 5


func xp_collected(ammount: int) ->void:

	collected_xp += ammount

	if collected_xp > required_xp:
		collected_xp -= required_xp
		level += 1
		set_new_required_ex(level)
		new_level.emit(level)

	GlobalInfo.combat_ui_overlay.update_progres_bar(level, collected_xp,required_xp)
	print("current level %d: %d/%d" % [level, collected_xp,required_xp])
