extends Area2D
class_name CompPickup

signal picked_up()

var _picked_up: bool = false

@export var pickup_type: String = ""


func reset() -> void:
	_picked_up = false


func _ready() -> void:
	reset()
	connect("area_entered", _on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is not CompPickupReceiver:
		return

	picked_up.emit()
	queue_free()
