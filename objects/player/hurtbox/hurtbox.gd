extends BaseHurtbox
class_name PlayerHurtbox

@onready var timer: Timer = $Timer
var invornerable : bool = false


func _ready() -> void:
	timer.connect("timeout",func(): invornerable = false)


func _process(_delta: float) -> void:
	if not invornerable:
		for area in get_overlapping_areas():
			var e := area.get_parent()

			if e is Enemy:
				got_hit(DamageParameters.new(e.get_contact_dmg()))
				invornerable = true
				timer.start()

				break
