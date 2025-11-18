extends PanelContainer
class_name ChoicePanelWeight

signal chosen()

@export var choice: Lottery
@export var disabled: bool:
	set(val):
		disabled = val
		%Button.disabled = disabled

@export var item_display: PackedScene
@export_range(0, 360, 0.1, "radians_as_degrees") var lottery_roll_speed: float = 0


func setup(_criterion: AssessCriterion, _choice: MultiLottery):
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


func _ready() -> void:
	disabled = disabled


func _physics_process(delta: float) -> void:
	if lottery_roll_speed > 0:
		%LotteryCursor.rotation_degrees = lottery_roll_speed * 20 + sin(deg_to_rad(Engine.get_physics_frames()) * 20) * 10
		%LotteryProgress.rotation += lottery_roll_speed


func _on_button_pressed() -> void:
	chosen.emit()
