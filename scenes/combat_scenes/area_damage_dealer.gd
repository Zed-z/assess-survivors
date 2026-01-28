extends Node

@export var spawnable_area: CollisionPolygon2D

@export var damage_percent: float = 0.5

var player: Player
var player_hp_comp: HealthComponent
var player_state: bool = false


func _ready() -> void:
	assert(is_instance_valid(spawnable_area))

	player = GlobalInfo.player
	player_hp_comp = player.get_node("HealthComponent")
	var timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(check_player_position)

	add_child(timer)


func _process(delta: float) -> void:
	if !Geometry2D.is_point_in_polygon(player.position,spawnable_area.polygon):
		if not player_state:
			player.get_node("WaterEnter").play()

		player_state = true
	else:
		if player_state:
			player.get_node("WaterLeave").play()

		player_state = false


func check_player_position():
	if player_state:
		player_hp_comp.take_damage(DamageParameters.new(damage_percent * player_hp_comp.health))
