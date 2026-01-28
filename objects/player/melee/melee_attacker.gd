extends Node2D
class_name MeleAtacker

@export var attack_area: Area2D
@export var stats: PlayerStats
@export var animation: AnimationPlayer

var user_action: bool = false
var last_action: float = 0


func _ready() -> void:
	assert(is_instance_valid(attack_area))
	assert(is_instance_valid(stats))
	assert(is_instance_valid(animation))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			user_action = true

		if event.is_released() and event.button_index == MOUSE_BUTTON_RIGHT:
			user_action = false


func _process(delta: float) -> void:
	attack_area.look_at(get_global_mouse_position())

	var curent_time = Time.get_unix_time_from_system()

	if user_action and curent_time - last_action> Utils.map_cooldown(stats.get_stat("STAT_COOLDOWN")):
		last_action = curent_time
		$SoundAttack.play()
		animation.stop()
		animation.play("sweep")

		var targets = attack_area.get_overlapping_areas()

		for target in targets:
			target = target as EnemyHurtbox

			if !is_instance_valid(target):
				continue;

			var targ = (target.global_position - global_position).normalized()
			print(targ)
			target.hit.emit(DamageParameters.new(stats.get_stat("STAT_MELEE"), targ))
