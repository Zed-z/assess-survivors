extends BaseProjectile
class_name ProjectilePlayer

var pierce_left = 1


func _on_area_entered(area: Area2D) -> void:
	super._on_area_entered(area)

	if area is BaseHurtbox and area is not PlayerHurtbox:
		area.got_hit(DamageParameters.new(damage))
		pierce_left-=1

		if pierce_left < 0:
			queue_free()
