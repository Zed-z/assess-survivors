extends Enemy
class_name EnemyBush

var is_up: bool = false
@onready var animation: AnimatedSprite2D = $SpriteContainer/AnimatedSprite2D

enum BUSH_STATE{
	UP,
	DOWN,
	SHOT_SEQUENCE,
	TAUNT
}

var current_state: BUSH_STATE = BUSH_STATE.DOWN
var animation_state: String

@export var tount_chance: float = 0.25
@export var action_cooldown: float = 4

var spawnable_area: PackedVector2Array

var can_act = 0


func _ready() -> void:
	spawnable_area = GlobalInfo.enemy_spawner.spawnable_area.polygon


func _physics_process(_delta: float) -> void:
	var received_velocity = move_controller.get_velocity()
	animation_state	= animation.animation

	if current_state == BUSH_STATE.DOWN:
		velocity= received_velocity

		if received_velocity.length() > 0.001:
			animation.play("walk")
		else:

			if can_act < 0:
				can_act = action_cooldown
				var behaviour: bool= randf_range(0,1) > tount_chance

				if behaviour:
					animation.play("get_up")
					current_state = BUSH_STATE.SHOT_SEQUENCE
				else:
					animation.play("taunt")
					current_state = BUSH_STATE.TAUNT

			else:
				can_act -=_delta

		if GlobalInfo.enemy_spawner.is_position_inside_area(position + velocity * _delta):
			move_and_slide()

	elif current_state == BUSH_STATE.UP:

		pass


func _on_animated_sprite_2d_animation_finished() -> void:

	if animation.animation == &"get_up":
		current_state = BUSH_STATE.SHOT_SEQUENCE
		animation.play(&"attack")
	elif animation.animation == &"hide":
		current_state = BUSH_STATE.DOWN
		animation.play(&"idle")
	elif animation.animation == &"attack":
		animation.play(&"hide")
	elif animation.animation == &"taunt":
		animation.play(&"idle")
		current_state = BUSH_STATE.DOWN
