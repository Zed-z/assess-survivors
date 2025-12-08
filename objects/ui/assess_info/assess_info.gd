extends PanelContainer
class_name Assess_Info

@export var assessmanger: AssessManagerClass
@export var metadata_visible: bool = true
@export var item_scene: PackedScene = preload("res://objects/ui/assess_criterion_info/assess_criterion_info.tscn")


func initialize_children() -> void:
	print("initializng")
	for i in range(len(assessmanger.criteria)):
		var item: AssessCriterionInfo = item_scene.instantiate()
		item.assesscriterion = assessmanger.criteria[i]
		item.weight = assessmanger.criteria_weight[i]
		%CriteriaContainer.add_child(item)


func _ready():
	get_tree().paused = true
