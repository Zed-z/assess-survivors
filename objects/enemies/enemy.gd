extends CharacterBody2D
class_name Enemy
var target: Player

@export var move_controller: MoveController
@export var move_animation: AnimatedSprite2D

@export var contact_dmg: int = 1

var wave_number: int


func get_contact_dmg() -> int:
	return contact_dmg


func scale_enemy(scaler : BaseEnemyScaler):
	contact_dmg *= scaler.get_attack_scale()

func _ready() -> void:
	assert(is_instance_valid(move_animation), name + " does not have animation assigned")
	target = GlobalInfo.player


func _physics_process(_delta: float) -> void:
	velocity = move_controller.get_velocity()

	if velocity.length_squared() > 0.0001:
		if move_animation.sprite_frames.has_animation("walk"):
			move_animation.play("walk")
		else:
			move_animation.play("default")
	else:
		if move_animation.sprite_frames.has_animation("idle"):
			move_animation.play("idle")
		else:
			move_animation.play("default")

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
