extends Area2D
class_name CompPickupReceiver

signal received_pickup(pickup_type: String)

var _picked_up: bool = false


func reset() -> void:
	_picked_up = false


func _ready() -> void:
	reset()
	connect("area_entered", _on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is not CompPickup:
		return

	var pickup := area as CompPickup

	received_pickup.emit(pickup.pickup_type)
