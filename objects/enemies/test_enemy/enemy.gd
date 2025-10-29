extends CharacterBody2D
class_name Enemy
var target: Player

var vave_number: int


func get_contact_dmg() -> int:
	return 1


func _ready() -> void:
	target = GlobalInfo.get_player()


func _physics_process(_delta: float) -> void:
	velocity = (target.position- position).normalized() * 10
	move_and_slide()


func die():
	get_parent().remove_enemy(self)
	GlobalInfo.score_manager.score_increase(100)
