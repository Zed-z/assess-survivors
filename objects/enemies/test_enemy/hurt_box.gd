extends Area2D

signal hit(parameters: DamageParameters)


func _on_area_entered(area: Area2D) -> void:
	if area is BaseProjectile:
		hit.emit(DamageParameters.new())
