extends Node2D
class_name MeleAtacker

@onready var attack_area: Area2D = $AttackArea
@onready var stats: PlayerStats = $"../Stats"

@export var damage : int


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			var targets = attack_area.get_overlapping_areas()

			for target in targets:
				target = target as EnemyHurtbox

				if !is_instance_valid(target):
					continue;

				target.hit.emit(DamageParameters.new(stats.get_stat("MELEE_STAT")))


func _process(delta: float) -> void:
	attack_area.look_at(get_global_mouse_position())
