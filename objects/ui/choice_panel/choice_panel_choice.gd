extends PanelContainer
class_name ChoicePanelChoice

signal chosen()

@export var criterion: AssessCriterion
@export var choice: Lottery
@export var disabled: bool:
	set(val):
		disabled = val
		%ButtonChooseNone.disabled = disabled

@export_range(0, 360, 0.1, "radians_as_degrees") var lottery_roll_speed: float = 0


func setup(_criterion: AssessCriterion, _choice: Lottery):
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


func _ready() -> void:
	disabled = disabled


func _physics_process(delta: float) -> void:
	if lottery_roll_speed > 0:
		%LotteryCursor.rotation_degrees = lottery_roll_speed * 20 + sin(deg_to_rad(Engine.get_physics_frames()) * 20) * 10
		%LotteryProgress.rotation += lottery_roll_speed


func _on_button_pressed() -> void:
	chosen.emit()
