class_name HealthComponent
extends Node

signal got_hit(depleted: bool)
signal health_changed(new_value: float)
signal max_health_changed(new_value: float)

@export var invulnerable: bool = false
@export var health: float = 1
@export var team: String = ""
@export var deplete_once: bool = true

var current_health: float = 1
var has_depleted: bool = false


func setup(_health: float):
	health = _health
	reset()


func reset():
	current_health = health
	has_depleted = false


func _ready() -> void:
	reset()


func new_max_health(value: float):
	var increase: float= value - health

	@warning_ignore("narrowing_conversion")
	current_health += increase

	health = value

	max_health_changed.emit(health)
	health_changed.emit(current_health)


func take_damage(damage: DamageParameters) -> void:

	if current_health <= 0 and deplete_once and has_depleted:
		return

	if invulnerable:
		return

	current_health -= damage.damage
	health_changed.emit(current_health)

	if current_health <= 0:

		if deplete_once and has_depleted:
			return

		got_hit.emit(true)
		has_depleted = true

	else:
		got_hit.emit(false)
