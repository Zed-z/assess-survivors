extends Control
class_name ChoicePanelFinalCard

@export var item_display: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_weight_item.tscn")
var variant: Dictionary[AssessCriterion, float]
var rank: int


func _ready() -> void:
	%Rank.text = str(rank)

	for stat in variant:
		var item: WeightItem = item_display.instantiate()
		item.criterion = stat
		item.val = variant[stat]
		%ValuesContainer.add_child(item)
