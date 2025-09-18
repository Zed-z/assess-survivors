extends Node2D

@export var player: Player

@export_group("spawn parameters")
@export var min_radius: float =100
@export var max_radius: float =200
@export var enemy: PackedScene


func _process(_delta: float) -> void:
	var radius = randf_range(min_radius,max_radius)
	var offset = Vector2(radius,0).rotated(randf_range(0,3.14 * 2))
	var e:Node2D= enemy.instantiate()
	add_child(e)
	e.global_position = player.global_position + offset
