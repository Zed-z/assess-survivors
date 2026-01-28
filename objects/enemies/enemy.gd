extends CharacterBody2D
class_name Enemy
var target: Player

@export var spawner: EnemySpawner

@export var move_controller: MoveController
@export var move_animation: AnimatedSprite2D

@export var shooter: BasicShooter

@export var contact_dmg: float = 1

var wave_number: int

@export var xp_reward: int = 1


func get_contact_dmg() -> float:
	return contact_dmg


func scale_enemy(scaler: BaseEnemyScaler):
	contact_dmg *= scaler.get_attack_scale()
	$HealthComponent.new_max_health($HealthComponent.health * scaler.get_health_scale())

	if shooter != null:
		shooter.damage *= scaler.get_attack_scale()


func _ready() -> void:
	assert(is_instance_valid(spawner))
	assert(is_instance_valid(move_animation), name + " does not have animation assigned")
	target = GlobalInfo.player

	$HealthBar.visible = SettingsManager.get_setting("video/enemy_health_bars")


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
		$HurtBox.monitorable = false
		$CollisionShape2D.queue_free()

		await $AnimationPlayer.animation_finished
		spawner.remove_enemy(self)
		GlobalInfo.score_manager.score_increase(100)
	else:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hit")


func _on_hurt_box_hit(parameters: DamageParameters) -> void:
	position += parameters.direction * 7
	GlobalInfo.game_camera.shake_scalable(Vector2(0.5,0.5),1)
