extends Node2D

var array: Array[Node2D]


func _ready() -> void:
	array.assign(get_children())


func _process(delta: float) -> void:
	var player_pos = GlobalInfo.player.position

	for x: Node2D in array:
		var pom = x.position.distance_squared_to(player_pos)
		print(x.name)
		x.modulate.a = 0#clamp(0.2,1,remap(pom,0,200,0.2,1))
