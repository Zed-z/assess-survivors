extends Node2D

var array: Array[Node2D]


func _ready() -> void:
	array.assign(get_children())


func _process(delta: float) -> void:
	var player_pos = GlobalInfo.player.position

	for x: Node2D in array:
		var pom = x.position.distance_squared_to(player_pos)

		x.modulate.a = clamp(0.5,1,remap(pom,4000,13000,0.5,1))
