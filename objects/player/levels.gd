extends Node

var level: int =0
var required_xp: int = 0
var collected_xp: int = 0

signal new_level(level: int)


func _ready() -> void:
	set_new_required_ex(0)
	await get_tree().process_frame
	GlobalInfo.enemy_spawner.enemy_killed.connect(gain_ex_from_enemy)
	GlobalInfo.combat_ui_overlay.update_progres_bar(level, collected_xp,required_xp)


func set_new_required_ex(_new_level: int):

	required_xp = 10 * _new_level + 5


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("force_level"):
		collected_xp = 0
		level += 1
		set_new_required_ex(level)
		new_level.emit(level)


func gain_ex_from_enemy(enemy: Enemy) -> void:
	collected_xp += 1

	xp_collected()


func gain_ex_by_value(xp_amoutn: int) -> void:
	collected_xp += xp_amoutn
	xp_collected()


##internal function not supesed to be called from outside
func xp_collected() ->void:

	if collected_xp >= required_xp:
		collected_xp -= required_xp
		level += 1
		set_new_required_ex(level)
		new_level.emit(level)

	GlobalInfo.combat_ui_overlay.update_progres_bar(level, collected_xp,required_xp)
