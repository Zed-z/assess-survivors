extends TextureProgressBar

var health: float
var max_health: float


func setup(_health: float, _max_health: float):
	health = _health
	max_health = _health
	update_label()


func set_health(_health: float):
	health = _health
	update_label()


func set_max_health(_max_health: float):
	max_health = _max_health
	update_label()


func update_label():
	value = health
	max_value = max_health
	$Label.text = tr("GAMEPLAY_HEALTH") % [health, max_health]
	$Icon/IconDead.visible = value / max_value < 0.3
