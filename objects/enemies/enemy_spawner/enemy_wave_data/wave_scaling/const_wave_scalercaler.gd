extends BaseEnemyScaler
class_name ConstWaveScaler

@export var health_scaling: float = 1
@export var attack_scaling: float = 1


func get_health_scale() -> float:
	return health_scaling


func get_attack_scale() -> float:
	return attack_scaling
