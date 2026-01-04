extends Control
class_name UIOverley
@onready var progress_bar: Range = $MarginContainer/Control/LevelBar
@onready var health_bar: Range = %HealthBar
@onready var wave_icon: TextureRect = %WaveInfo/TextureRect
@onready var wave_label: Label = %WaveInfo/WaveLabel
@onready var wave_number_label: Label = %WaveNumberLabel
@onready var stat_panel: StatPanel = $MarginContainer/Control/StatPanel


func _ready() -> void:
	GlobalInfo.combat_ui_overlay = self

	set_score(GlobalInfo.score_manager.score)
	GlobalInfo.score_manager.score_changed.connect(set_score)


func set_score(score: int):
	%ScoreLabel.text = tr("GAMEPLAY_SCORE_COUNTER") % score


func update_progres_bar(level: int, curent: int, max_value: int):
	progress_bar.value = curent
	progress_bar.max_value = max_value
	var label: Label = progress_bar.get_node("Label")
	label.text = tr("GAMEPLAY_LEVEL_BAR") % [level + 1, curent, max_value]


func _on_pause_button_pressed() -> void:
	var s = ObjectManager.instantiate(ObjectManager.OBJ_PAUSE_MENU)
	get_parent().add_child(s)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_pause_button_pressed()
