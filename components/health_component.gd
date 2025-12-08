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


func setup(_health: float):
	health = _health
	reset()


func reset():
	current_health = health


func _ready() -> void:
	reset()


func new_max_health(value: float):
	var increase: float= value - health

	current_health += increase

	health = value

	max_health_changed.emit(health)
	health_changed.emit(current_health)


func take_damage(damage: DamageParameters) -> void:

	if current_health <= 0:
		return

	if invulnerable:
		return

	current_health -= damage.damage
	health_changed.emit(current_health)

	got_hit.emit(current_health <= 0)


func heal(healing: float) -> void:
	current_health += healing
	current_health = clampf(current_health,0,health)
	health_changed.emit(current_health)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("force_kill"):
		var damage: DamageParameters = DamageParameters.new(ceil(current_health))
		take_damage(damage)
