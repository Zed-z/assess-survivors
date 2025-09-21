extends Node

var level: int =0
var required_xp: int = 0
var collected_xp: int = 0


func _ready() -> void:
	await get_tree().process_frame
	GlobalInfo.enemy_spawner.enemy_killed.connect(xp_collected)
	set_new_required_ex(0)


func set_new_required_ex(new_level: int):
	required_xp = 10 * new_level + 5


func xp_collected(ammount: int) ->void:

	collected_xp += ammount

	if collected_xp > required_xp:
		collected_xp -= required_xp
		level+=1
		set_new_required_ex(level)

	GlobalInfo.combat_ui_overlay.update_progres_bar(collected_xp,required_xp)
	print("current level %d: %d/%d" % [level, collected_xp,required_xp])
