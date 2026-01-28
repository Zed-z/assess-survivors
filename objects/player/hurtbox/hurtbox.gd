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
				await got_hit(DamageParameters.new(e.get_contact_dmg()))
				activate_timer()

				break


func activate_timer():
	invornerable = true
	timer.start()
