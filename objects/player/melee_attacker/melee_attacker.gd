extends PlayerAction
class_name PlayerActionMeleeAttacker

@export var attack_area: Area2D
@export var animation: AnimationPlayer


func _process(delta: float) -> void:
	attack_area.look_at(get_global_mouse_position())


func get_cooldown():
	return Utils.map_cooldown(player.stats.get_stat("STAT_COOLDOWN"))


func execute_action():
	$SoundAttack.play()
	animation.stop()
	animation.play("sweep")

	var targets = attack_area.get_overlapping_areas()

	for target in targets:
		if target is EnemyHurtbox:
			target = target as EnemyHurtbox

			if !is_instance_valid(target):
				continue;

			var targ = (target.global_position - global_position).normalized()
			target.hit.emit(DamageParameters.new(player.stats.get_stat("STAT_MELEE"), targ))
