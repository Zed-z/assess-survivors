extends GdUnitTestSuite

@onready var multilottery_script: GDScript = preload("res://globals/assess_criterion_manager/lottery/multi_lottery.gd")

var tested: MultiLottery


#func after_test() -> void:
	#tested.free()


func before_test() -> void:
	tested = MultiLottery.new({"ATK": 100, "HP":10, "DEF":10}, 0.5, {"ATK":100, "HP":100, "DEF":100})


func after_test() -> void:
	tested.free()


func test_to_string() -> void:
	#tested._init({"ATK": 100, "HP":10, "DEF":10}, 0.5, {"ATK":100, "HP":100, "DEF":100})
	assert_float(tested.win_probability).is_equal_approx(0.5, 0.01)
	assert_str(str(tested)).contains("[ATK : 100.00, HP : 10.00, DEF : 10.00]")
