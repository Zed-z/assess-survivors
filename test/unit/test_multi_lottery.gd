extends GdUnitTestSuite

@onready var multilottery_script: GDScript = preload("res://globals/assess_criterion_manager/lottery/multi_lottery.gd")

var tested: MultiLottery

var atk: AssessCriterion = AssessCriterion.new()
var hp: AssessCriterion = AssessCriterion.new()
var def: AssessCriterion = AssessCriterion.new()


#func after_test() -> void:
	#tested.free()


func before_test() -> void:
	atk.criterion_name = "ATK"
	hp.criterion_name = "HP"
	def.criterion_name = "DEF"

	tested = MultiLottery.new({atk: 100, hp:10, def:10}, 0.5, {atk:100, hp:100, def:100})


func after_test() -> void:
	tested.free()


func test_to_string() -> void:
	#tested._init({"ATK": 100, "HP":10, "DEF":10}, 0.5, {"ATK":100, "HP":100, "DEF":100})
	assert_float(tested.win_probability).is_equal_approx(0.5, 0.01)
	assert_str(str(tested)).contains("[ATK : 100.00, HP : 10.00, DEF : 10.00]")
