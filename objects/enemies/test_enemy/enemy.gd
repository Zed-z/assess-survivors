extends CharacterBody2D

var target: Player


func _ready() -> void:
	target = GlobalInfo.get_player()


func _physics_process(_delta: float) -> void:
	velocity = (target.position- position).normalized() * 10
	move_and_slide()


func die():
	get_parent().remove_enemy(self)
