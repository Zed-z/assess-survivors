extends Node

var level: int =0
var required_xp: int = 0
var collected_xp: int = 0

signal xp_changed(level: int, xp: int)
signal new_level(level: int)


func _ready() -> void:
	set_new_required_ex(0)
	await get_tree().process_frame
	GlobalInfo.enemy_spawner.enemy_killed.connect(gain_ex_from_enemy)

	_xp_changed()


func set_new_required_ex(_new_level: int):
	required_xp = 10 * _new_level + 5


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("force_level") and GlobalInfo.is_debug:
		gain_level(1)


func gain_ex_from_enemy(enemy: Enemy) -> void:
	collected_xp += enemy.xp_reward
	_xp_changed()


func gain_ex_by_value(xp_amoutn: int) -> void:
	collected_xp += xp_amoutn
	_xp_changed()


func gain_level(levels: int = 1) -> void:

	for i in range(levels):
		collected_xp = 0
		level += 1
		set_new_required_ex(level)
		new_level.emit(level)

	_xp_changed()


##internal function not supesed to be called from outside
func _xp_changed() ->void:

	if collected_xp >= required_xp:
		collected_xp -= required_xp
		level += 1
		set_new_required_ex(level)
		new_level.emit(level)

	xp_changed.emit(level, collected_xp)
	GlobalInfo.combat_ui_overlay.update_progres_bar(level, collected_xp,required_xp)
