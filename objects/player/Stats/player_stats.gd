extends Node
class_name PlayerStats

enum STATS{
	HP,
	DEFENCE,
	ATTACK
}

@export var Stats : Dictionary[STATS,BaseStat]


func _ready() -> void:
	for stat_type  in STATS:
		Stats[stat_type].stat_type = STATS
