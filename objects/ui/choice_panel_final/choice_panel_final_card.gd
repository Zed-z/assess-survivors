extends Control
class_name ChoicePanelFinalCard

@export var item_display: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_weight_item.tscn")
@export var disabled: bool:
	set(val):
		disabled = val
		%Button.disabled = disabled

var variant: Dictionary[AssessCriterion, float]
var utility: float
var rank: int

signal variant_chosen(variant: Dictionary[AssessCriterion, float],rank: int)


func _ready() -> void:
	disabled = disabled
	%Rank.text = str(rank)
	%Utility.text = "%.2f%%" % (utility * 100)

	for stat in variant:
		var item: WeightItem = item_display.instantiate()
		item.criterion = stat
		item.val = variant[stat]
		%ValuesContainer.add_child(item)


func _on_button_pressed() -> void:
	variant_chosen.emit(variant, rank)
