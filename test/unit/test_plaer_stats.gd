extends GdUnitTestSuite


@onready var player_scene:PackedScene  = preload("res://objects/player/player.tscn")

var player_stats: PlayerStats
var player: Player




func before_test():
	player = player_scene.instantiate() as Player
	player_stats = player.get_node("Stats") as PlayerStats




func after_test():
	player.free()

func test_player_stats_is_null():
	assert_object(player_stats).is_not_null()

func test_player_stats_stats_is_null():
	assert_object(player_stats.stats).is_not_null()

func test_player_stats():
	for key in PlayerStats.STATS.values():
		assert_bool(player_stats.stats.has(key)).append_failure_message("%s was not found" % PlayerStats.STATS.keys()[key]).is_true()
