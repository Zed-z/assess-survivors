extends Node

@onready var spawnable_area: CollisionPolygon2D = $"../EnemySpawner/SpawnableArea"

@export var damage : float = 0.5

var player: Player
var player_hp_comp: HealthComponent


func _ready() -> void:
	player = GlobalInfo.player
	player_hp_comp = player.get_node("HealthComponent")
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(check_player_position)

	add_child(timer)


func check_player_position():
	if !Geometry2D.is_point_in_polygon(player.position,spawnable_area.polygon):
		player_hp_comp.take_damage(DamageParameters.new(damage))
