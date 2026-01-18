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

var rotation_tween: Tween


func _ready() -> void:
	disabled = disabled


func _physics_process(delta: float) -> void:
	if lottery_roll_speed > 0:
		%LotteryCursor.rotation_degrees = lottery_roll_speed * 20 + sin(deg_to_rad(Engine.get_physics_frames()) * 20) * 10


func _on_button_pressed() -> void:
	chosen.emit()


func start_lottery_animation(lottery: Lottery, win: bool, anim_length: float) -> void:
	lottery_roll_speed = PI/10

	if (rotation_tween):
		rotation_tween.kill()

	rotation_tween = create_tween().set_ease(Tween.EASE_OUT)

	var target_probability = randf_range(0, lottery.win_probability) if win\
							else randf_range(lottery.win_probability, 1)

	rotation_tween.tween_property(
		%LotteryProgress,
		"rotation",
		2 * PI * (2 - target_probability),
		anim_length)

	rotation_tween.play()


func stop_lottery_animation(win: bool) -> void:
	lottery_roll_speed = 0
