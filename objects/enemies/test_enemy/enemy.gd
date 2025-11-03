extends CharacterBody2D
class_name Enemy
var target: Player

var vave_number: int

@export var move_controller: MoveController


func get_contact_dmg() -> int:
	return 1


func _ready() -> void:
	target = GlobalInfo.get_player()


func _physics_process(_delta: float) -> void:
	velocity = move_controller.get_velocity()
	move_and_slide()


func die():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")

	await $AnimationPlayer.animation_finished
	get_parent().remove_enemy(self)
	GlobalInfo.score_manager.score_increase(100)


func _on_health_component_got_hit() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
