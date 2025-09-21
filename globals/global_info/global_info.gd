extends Node

var player: Player
var combat_ui_overlay: UIOverley
var enemy_spawner: EnemySpawner


func _ready() -> void:
	pass


func get_player()->Player:
	if !is_instance_valid(player):
		player = get_tree().get_first_node_in_group("Player") as Player

	return player
