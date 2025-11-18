extends ChoicePanelCard
class_name ChoicePanelWeight

@export var item_display: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_weight_item.tscn")


func setup(_criterion: AssessCriterion, _choice: MultiLottery):

	%LotteryProgress.value = _choice.win_probability

	if (_choice.win_probability == 1):
		%SureOption.visible = true
		%Lottery.visible = false
		%Button.text = tr("CHOICE_PANEL_SAFE")
		fill_container(_choice.win_array, %SureContainer)
	else:
		%SureOption.visible = false
		%Lottery.visible = true
		%Button.text = tr("CHOICE_PANEL_SPIN")
		fill_container(_choice.win_array, %WinContainer)
		fill_container(_choice.loss_array, %LossContainer)


func fill_container(dict: Dictionary[AssessCriterion, float], container: BoxContainer) -> void:
	for key in dict:
		var item = item_display.instantiate()
		item.criterion = key
		item.val = dict[key]
		container.add_child(item)
