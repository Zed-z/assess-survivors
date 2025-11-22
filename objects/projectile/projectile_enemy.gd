extends BaseProjectile
class_name ProjectileEnemy


func _on_area_entered(area: Area2D) -> void:
	if area is BaseHurtbox and area is not EnemyHurtbox:
		area.got_hit(DamageParameters.new(damage))
