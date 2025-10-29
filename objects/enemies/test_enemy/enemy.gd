extends CharacterBody2D
class_name Enemy
var target: Player

var vave_number: int

@onready var move_controller:MoveController = $MoveController


func get_contact_dmg() -> int:
	return 1


func _ready() -> void:
	target = GlobalInfo.get_player()


func _physics_process(_delta: float) -> void:
	velocity = move_controller.get_velocity()
	move_and_slide()


func die():
	get_parent().remove_enemy(self)
