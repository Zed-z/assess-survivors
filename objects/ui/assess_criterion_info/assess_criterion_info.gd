extends Control
class_name AssessCriterionInfo

@export var assesscriterion: AssessCriterion
@export var weight: float


func _ready() -> void:
	%Name.text = assesscriterion.criterion_name
	%Icon.texture = assesscriterion.icon
	%Weight.text = "Weight:" + str(weight)

	var chart: ChartVisualizer = ObjectManager.instantiate(ObjectManager.OBJ_CHART_VISUALIZER)
	chart.set_title(assesscriterion.criterion_name)
	%ChartContainer.add_child(chart)

	assesscriterion.points_changed.connect(chart.set_points)
	chart.set_points(assesscriterion.point_list)
