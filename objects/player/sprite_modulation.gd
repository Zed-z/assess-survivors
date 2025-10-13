extends Sprite2D
@onready var hurtbox: PlayerHurtbox = $"../Hurtbox"

@export var invornerable_color : Color


func _process(_delta: float) -> void:
	self_modulate = invornerable_color if hurtbox.invornerable else Color.WHITE
