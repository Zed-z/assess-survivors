extends Node2D
@onready var hurtbox: PlayerHurtbox = $"../Hurtbox"

@export var invulnerable_color : Color = Color(0.0, 0.0, 0.0, 0.25)

var game_time = 0


func _process(_delta: float) -> void:
	game_time += _delta

	if hurtbox.invornerable:
		modulate = invulnerable_color
		modulate.a += clamp(sin(game_time * 10) * 0.5,-0.15,0.15)
	else:
		modulate = Color.WHITE
