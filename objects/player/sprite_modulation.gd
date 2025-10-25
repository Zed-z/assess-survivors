extends Sprite2D
@onready var hurtbox: PlayerHurtbox = $"../Hurtbox"

@export var invornerable_color : Color

var game_time = 0


func _process(_delta: float) -> void:
	game_time += _delta

	if hurtbox.invornerable:
		self_modulate = invornerable_color
		self_modulate.a += clamp(sin(game_time * 10) * 0.5,-0.15,0.15)
	else:
		self_modulate = Color.WHITE
