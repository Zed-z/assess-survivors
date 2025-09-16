extends Node
class_name PlayerStats

enum STATS{
	HP,
	DEFENCE,
	ATTACK
}

@export var Stats : Dictionary[STATS,BaseStat]


func _ready() -> void:
	for stat : STATS in STATS.values():
		Stats[stat].stat_type = stat
