extends Node
class_name PlayerStats

@export var stats: PlayerStatsResource


func _ready() -> void:
	match GlobalInfo.game_type:
		GlobalInfo.GameType.Quick:
			stats = load("res://objects/player/Stats/player_stats_quick.tres")

		GlobalInfo.GameType.Normal:
			stats = load("res://objects/player/Stats/player_stats_default.tres")

	for stat in stats.stats.values():
		stat.init()


func get_stat(stat: String):
	return stats.stats[stat].get_stat()


func get_stat_raw(stat: String) -> BaseStat:
	return stats.stats[stat]


func values():
	return stats.stats.values()
