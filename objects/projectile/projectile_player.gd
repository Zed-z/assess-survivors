extends BaseProjectile
class_name ProjectilePlayer


func _on_area_entered(area: Area2D) -> void:
	if area is BaseHurtbox and area is not PlayerHurtbox:
		area.got_hit(DamageParameters.new(damage))
