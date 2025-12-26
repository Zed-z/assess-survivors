extends VBoxContainer
class_name AssessInfo

@export var assessmanger: AssessManagerClass
@export var item_scene: PackedScene = preload("res://objects/ui/assess_criterion_info/assess_criterion_info.tscn")


func setup(assess_manager: AssessManagerClass):
	assessmanger = assess_manager

	if len(assessmanger.criteria) >= 5:
		%CriteriaContainer.columns = 3
	elif len(assessmanger.criteria) >= 2:
		%CriteriaContainer.columns = 2
	else:
		%CriteriaContainer.columns = 1

	for i in range(len(assessmanger.criteria)):
		var item: AssessCriterionInfo = item_scene.instantiate()
		item.assesscriterion = assessmanger.criteria[i]
		item.weight = assessmanger.criteria_weight[i]
		%CriteriaContainer.add_child(item)


func _ready() -> void:
	if assessmanger != null:
		setup(assessmanger)
