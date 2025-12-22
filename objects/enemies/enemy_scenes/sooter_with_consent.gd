extends BasicShooter

var queue_shoot:bool = false


func _process(delta: float) -> void:
	if queue_shoot:
		queue_shoot = false
		super.shoot_projectile()


func shoot_projectile():
	if $"../WalkingBushMoveCantroler".can_shoot:
		queue_shoot = true
