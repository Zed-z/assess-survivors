extends ChoicePanelCard
class_name ChoicePanelChoice


func setup(_criterion: AssessCriterion, _choice: SingleLottery):
	criterion = _criterion
	choice = _choice

	%Label.text = choice._to_pretty_string()

	%LotteryProgress.value = choice.win_probability

	if (choice.win_probability == 1):
		%SureOption.visible = true
		%Lottery.visible = false
		%Button.text = tr("CHOICE_PANEL_SAFE")
	else:
		%SureOption.visible = false
		%Lottery.visible = true
		%Button.text = tr("CHOICE_PANEL_SPIN")

	%SureIcon.texture = criterion.icon
	%LotteryIcon.texture = criterion.icon
