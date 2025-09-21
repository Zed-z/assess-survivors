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
		var s: BaseStat = stats.get_or_add(stat,BaseStat.new())
		s.stat_type = stat
		s.init()
