extends Enemy
class_name EnemyBush

var is_up: bool = false
@onready var animation: AnimatedSprite2D = $SpriteContainer/AnimatedSprite2D

enum BUSH_STATE{
	UP,
	DOWN,
	SHOT_SEQUENCE
}

var current_state: BUSH_STATE = BUSH_STATE.DOWN
var animation_state: String

@export var tount_chance: float = 0.25


func _physics_process(_delta: float) -> void:
	var received_velocity = move_controller.get_velocity()
	animation_state	= animation.animation

	if current_state == BUSH_STATE.DOWN:
		velocity= received_velocity

		if received_velocity.length() > 0.001:
			animation.play("walk")
		else:
			var behaviour = MathUtils.choices_1f([tount_chance, 1- tount_chance])

			if behaviour == 0:
				animation.play("taunt")
			else:
				animation.play("get_up")

		move_and_slide()

	elif current_state == BUSH_STATE.UP:

		pass


func _on_animated_sprite_2d_animation_finished() -> void:

	if animation.animation == &"get_up":
		current_state = BUSH_STATE.SHOT_SEQUENCE
		animation.play(&"attack")
	elif animation.animation == &"hide":
		current_state = BUSH_STATE.DOWN
		animation.play(&"walk")
	elif animation.animation == &"attack":
		animation.play(&"hide")
	elif animation.animation == &"taunt":
		animation.play(&"idle")
		current_state = BUSH_STATE.DOWN
