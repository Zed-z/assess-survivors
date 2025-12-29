extends PanelContainer
class_name AssessCriterionInfo

var assesscriterion: AssessCriterion


func set_weight(weight: float):
	%Weight.text = tr("ASSESS_WEIGHT") % weight


func set_risk(risk: float):
	%RiskFactor.text = Utils.risk_to_string(risk)


func _ready() -> void:
	%Name.text = assesscriterion.criterion_name
	%Icon.texture = assesscriterion.icon

	set_weight(assesscriterion.weight)
	assesscriterion.weight_changed.connect(set_weight)

	var chart: ChartVisualizer = ObjectManager.instantiate(ObjectManager.OBJ_CHART_VISUALIZER)
	chart.show_title = false
	chart.set_title(assesscriterion.criterion_name)
	%ChartContainer.add_child(chart)

	assesscriterion.points_changed.connect(chart.set_points)
	chart.set_points(assesscriterion.point_list)

	set_risk(assesscriterion.risk_factor)
	assesscriterion.risk_changed.connect(set_risk)
