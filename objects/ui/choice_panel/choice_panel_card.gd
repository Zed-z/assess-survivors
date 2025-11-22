extends PanelContainer
class_name ChoicePanelCard
signal chosen()
@export var criterion: AssessCriterion
@export var choice: Lottery
@export var disabled: bool:
	set(val):
		disabled = val
		%Button.disabled = disabled

@export_range(0, 360, 0.1, "radians_as_degrees") var lottery_roll_speed: float = 0


func _ready() -> void:
	disabled = disabled


func _physics_process(delta: float) -> void:
	if lottery_roll_speed > 0:
		%LotteryCursor.rotation_degrees = lottery_roll_speed * 20 + sin(deg_to_rad(Engine.get_physics_frames()) * 20) * 10
		%LotteryProgress.rotation += lottery_roll_speed


func _on_button_pressed() -> void:
	chosen.emit()


func start_lottery_animation() -> void:
	lottery_roll_speed = PI/10


func stop_lottery_animation(win: bool) -> void:
	lottery_roll_speed = 0
