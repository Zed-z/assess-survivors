extends Area2D
class_name CompPickupReceiver

signal received_pickup(pickup_type: String)


func _ready() -> void:

	connect("area_entered", _on_area_entered)
	connect("received_pickup",hard_coded_pickups)


#ALERT this is very bad but time is short
#can be rewriten so that it is better
func hard_coded_pickups(type: String):

	match type:
		"health":
			$"../HealthComponent".reset()

		"xp":
			$"../Levels".gain_level(1)


func _on_area_entered(area: Area2D) -> void:
	if area is not CompPickup:
		return

	$SoundPickup.play()

	var pickup := area as CompPickup

	received_pickup.emit(pickup.pickup_type)
