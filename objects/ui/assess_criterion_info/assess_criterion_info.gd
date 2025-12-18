extends PanelContainer
class_name AssessCriterionInfo

var assesscriterion: AssessCriterion
var weight: float


func _risk_into_verbose_string(value: float, method: AssessCriterion.RiskCalculationMode):
	var label: String = ""

	match method:
		AssessCriterion.RiskCalculationMode.area_minus_perfectline:
			label = "area - perfect line"

		AssessCriterion.RiskCalculationMode.area_minus_perfectline_over_perfectline:
			label = "(area - perfect line) / (perfect line)"

	return "%0.2f calculated with method: %s" % [value, label]


func _ready() -> void:
	%Name.text = assesscriterion.criterion_name
	%Icon.texture = assesscriterion.icon
	%Weight.text = "Weight:" + str(weight)

	var chart: ChartVisualizer = ObjectManager.instantiate(ObjectManager.OBJ_CHART_VISUALIZER)
	chart.show_title = false
	chart.set_title(assesscriterion.criterion_name)
	%ChartContainer.add_child(chart)

	assesscriterion.points_changed.connect(chart.set_points)
	chart.set_points(assesscriterion.point_list)

	%RiskFactor.text = Utils.risk_to_string(assesscriterion.risk_factor, assesscriterion.risk_method)
