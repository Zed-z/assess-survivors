extends ProgressBar

var health: float
var max_health: float


func setup(_health: int, _max_health: int):
	health = _health
	max_health = _health
	update_label()


func set_health(_health: int):
	health = _health
	update_label()


func set_max_health(_max_health: int):
	max_health = _max_health
	update_label()


func update_label():
	value = health
	max_value = max_health
	$Label.text = tr("GAMEPLAY_HEALTH") % [health, max_health]
