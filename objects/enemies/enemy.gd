extends CharacterBody2D
class_name Enemy
var target: Player

@export var move_controller: MoveController

var wave_number: int


func get_contact_dmg() -> int:
	return 1


func _ready() -> void:
	target = GlobalInfo.get_player()


func _physics_process(_delta: float) -> void:
	velocity = move_controller.get_velocity()
	move_and_slide()


func _on_health_component_got_hit(depleted: bool) -> void:
	if depleted:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("die")

		await $AnimationPlayer.animation_finished
		get_parent().remove_enemy(self)
		GlobalInfo.score_manager.score_increase(100)
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hit")
