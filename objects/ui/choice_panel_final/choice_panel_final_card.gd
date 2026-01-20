extends Control
class_name ChoicePanelFinalCard

@export var item_display: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_weight_item.tscn")
var variant: Dictionary[AssessCriterion, float]
var rank: int

signal variant_chosen(variant: Dictionary[AssessCriterion, float],rank: int)


func _ready() -> void:
	%Rank.text = str(rank)
	#TODO: translate
	%Button.text = "Chose me"

	for stat in variant:
		var item: WeightItem = item_display.instantiate()
		item.criterion = stat
		item.val = variant[stat]
		%ValuesContainer.add_child(item)


func _on_button_pressed() -> void:
	variant_chosen.emit(variant, rank)
