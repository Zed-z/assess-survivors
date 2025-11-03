extends Node
class_name PlayerStats

@export var stats: Dictionary[String, BaseStat]


func _ready() -> void:
	for stat in stats.values():
		stat.init()


func get_stat(stat: String):
	return stats[stat].get_stat()


func get_stat_raw(stat: String) -> BaseStat:
	return stats[stat]
