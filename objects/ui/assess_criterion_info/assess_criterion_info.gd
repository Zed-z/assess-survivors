extends PanelContainer
class_name AssessCriterionInfo

var assesscriterion: AssessCriterion
var weight: float


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

	%RiskFactor.text = Utils.risk_to_string(assesscriterion.risk_factor)
