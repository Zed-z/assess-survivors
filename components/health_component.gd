class_name HealthComponent
extends Node

signal got_hit(depleted: bool)
signal health_changed(new_value: int)
signal max_health_changed(new_value: int)

@export var invulnerable: bool = false
@export var health: int = 1
@export var team: String = ""
@export var deplete_once: bool = true

var current_health: int = 1
var has_depleted: bool = false


func setup(_health: int):
	health = _health
	reset()


func reset():
	current_health = health
	has_depleted = false


func _ready() -> void:
	reset()


func new_max_health(value: int):
	var ratio = current_health / (health as float)

	@warning_ignore("narrowing_conversion")
	current_health = ratio * value

	health = value

	max_health_changed.emit(health)


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
