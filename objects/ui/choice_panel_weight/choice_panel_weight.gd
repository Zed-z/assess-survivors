extends ChoicePanelCard
class_name ChoicePanelWeight

@export var item_display: PackedScene = preload("res://objects/ui/choice_panel_weight/choice_panel_weight_item.tscn")
var prob_display: Label


func setup(_criterion: AssessCriterion, _choice: MultiLottery):
	criterion = _criterion
	choice = _choice

	%LotteryProgress.value = _choice.win_probability

	if (_choice.win_probability == 1):
		%SureOption.visible = true
		%SureContainer.visible = true
		%LotteryContainer.visible = false
		%Lottery.visible = false
		%Button.text = tr("CHOICE_PANEL_SAFE")
		%SureIcon.texture = _criterion.icon
		fill_container(_choice.win_array, 1, %SureContainer)
	else:
		%SureOption.visible = false
		%Lottery.visible = true
		%SureContainer.visible = false
		%LotteryContainer.visible = true
		%Button.text = tr("CHOICE_PANEL_SPIN")

		for key in _choice.win_array:
			%LotteryIcon.icons.append(key.icon)

		%LotteryIcon.fill()
		fill_container(_choice.win_array,_choice.win_probability, %WinContainer)
		fill_container(_choice.loss_array,_choice.loss_probability, %LossContainer)


func fill_container(dict: Dictionary[AssessCriterion, float], probability: float, container: BoxContainer) -> void:
	if probability >= 1:
		pass
	else:
		var prob_label: Label = Label.new()
		prob_label.text = "CHANCE: " + str(probability*100).pad_decimals(2)
		container.add_child(prob_label)

	for key in dict:
		var item = item_display.instantiate()
		item.criterion = key
		item.val = dict[key]
		container.add_child(item)


func stop_lottery_animation(win: bool) -> void:
	super.stop_lottery_animation(win)
	%LotteryResult.text = "WIN" if win else "LOSE"

	$VBoxContainer/LotteryContainer/Label.modulate = Color(1, 1, 1, 0.5)

	if win:
		%LossContainer.modulate = Color(1, 1, 1, 0.5)
	else:
		%WinContainer.modulate = Color(1, 1, 1, 0.5)
