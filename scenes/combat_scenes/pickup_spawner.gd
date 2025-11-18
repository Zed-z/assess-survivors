extends Node2D
class_name PickupSpawner

@export_range(0,1,0.01) var spawn_chance: float
@export var pickups: Array[PackedScene]


func spawn_pickup(enemy: Enemy):
	var selected_pickup = pickups.pick_random()
	var instance:Area2D= selected_pickup.instantiate()
	instance.global_position = enemy.global_position
	add_child(instance)
