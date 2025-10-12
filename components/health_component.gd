class_name HealthComponent
extends Node

signal got_hit()
signal health_dropped()
signal health_depleted()

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


func take_damage(damage: DamageParameters) -> void:

	if current_health <= 0 and deplete_once and has_depleted:
		return

	got_hit.emit()

	if not invulnerable:
		current_health -= damage.damage
		health_dropped.emit()

		if current_health <= 0:

			if deplete_once and has_depleted:
				return

			health_depleted.emit()
			has_depleted = true
