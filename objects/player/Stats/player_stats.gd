extends Node
class_name PlayerStats

enum STATS{
	HP,
	DEFENCE,
	ATTACK
}

@export var stats: Dictionary[STATS,BaseStat]


func _ready() -> void:

	for stat: STATS in STATS.values():
		stats.get_or_add(stat,BaseStat.new()).stat_type = stat
