extends Resource
class_name WaveData


##class that represents a wave data
##all keys should sum up to one
#TODO: make unit test for keys == 1

##how many enemies should be spawned each minute
@export var enemies_per_minute: int = 10
##what is the maxmimum number of enemies on the screen
@export var enemy_cap: int = 200

## is there a speficic limit to spawned enemies
@export var enemies_to_spawn: int = -1

##should all enemies be killed to proceed to next wave
@export var kill_all_enemies: bool = false

##what is the duration of current wave
@export var wave_duration: float

##the aray of enemies and their probabilities
@export var enemies: Array[WaveTouple] = []

@export var is_endless: bool

@export var scaling: BaseEnemyScaler


func get_status(enemies_killed: int, time: float) -> String:
	if kill_all_enemies:
		return "%d / %d" % [enemies_killed, enemies_to_spawn]
	else:
		return "%d s" % [time]
