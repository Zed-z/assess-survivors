extends Node2D
class_name AssessManager

@export var criteria_scripts: Array[Script] = []
var criteria: Array[AssessCriterion] = []

func _ready() -> void:

	for criterion: GDScript in criteria_scripts:
		var c: AssessCriterion = criterion.new()
		criteria.append(c)
		add_child(c)
