extends Area2D

signal hit(parameters: DamageParameters)

@onready var timer: Timer = $Timer
var invornerable : bool = false


func _ready() -> void:
	timer.connect("timeout",func(): invornerable = false)


func _process(_delta: float) -> void:
	if not invornerable:
		for area in get_overlapping_areas():
			if area.get_parent() is Enemy:
				hit.emit(DamageParameters.new())
				invornerable = true
				timer.start()

				break
