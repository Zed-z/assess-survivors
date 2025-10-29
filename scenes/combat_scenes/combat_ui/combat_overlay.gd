extends Control
class_name UIOverley
@onready var progress_bar: ProgressBar = $MarginContainer/Control/LevelBar
@onready var helth_bar: ProgressBar = $MarginContainer/Control/HealthBar
@onready var wave_label: Label = $MarginContainer/Control/WaveLabel
@onready var stat_panel: StatPanel = $MarginContainer/Control/StatPanel


func _ready() -> void:
	GlobalInfo.combat_ui_overlay = self

	set_score(GlobalInfo.score_manager.score)
	GlobalInfo.score_manager.score_changed.connect(set_score)


func set_score(score: int):
	$MarginContainer/Control/ScoreLabel.text = "Score\n" + "%08d" % score


func update_progres_bar(level: int, curent: int, max_value: int):
	progress_bar.value = curent
	progress_bar.max_value = max_value
	progress_bar.get_node("Label").text = tr("GAMEPLAY_LEVEL_BAR") % [level + 1, curent, max_value]
