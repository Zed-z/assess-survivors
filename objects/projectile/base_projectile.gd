extends Area2D
class_name BaseProjectile

var direction: Vector2
var damage: int


func initiate_projectile(vec: Vector2) -> void:
	direction = vec


func _process(delta: float) -> void:
	position += direction * delta


func _on_area_entered(area: Area2D) -> void:
	if area is BaseHurtbox and area is not PlayerHurtbox:
		area.got_hit(DamageParameters.new(damage))
