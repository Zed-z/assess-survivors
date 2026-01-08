extends BaseEnemyScaler
class_name EndlessWaveScaler

var start_timestamp: float = 0

@export var starting_scale_health: float = 1
@export var scale_after_one_min_health: float = 3

@export var starting_scale_attack: float = 1
@export var scale_after_one_min_attack: float = 3


func get_health_scale() -> float:
	if start_timestamp == 0:
		start_timestamp = Time.get_unix_time_from_system()

	var difference = (Time.get_unix_time_from_system() - start_timestamp) * 0.01666666666666

	return lerpf(starting_scale_health,scale_after_one_min_health,difference)


func get_attack_scale() -> float:
	if start_timestamp == 0:
		start_timestamp = Time.get_unix_time_from_system()

	var difference = (Time.get_unix_time_from_system() - start_timestamp) * 0.01666666666666

	return lerpf(starting_scale_attack,scale_after_one_min_attack,difference)
