extends Control
class_name UIOverley
@onready var progress_bar: ProgressBar = $ProgressBar

@onready var helth_bar: ProgressBar = $HelthBar
@onready var wave_label: Label = $WaveLabel


func _ready() -> void:
	GlobalInfo.combat_ui_overlay = self


func update_progres_bar(level: int, curent: int, max_value: int):
	progress_bar.value = curent
	progress_bar.max_value = max_value

	$ProgressBar/Label.text = tr("GAMEPLAY_LEVEL_BAR") % [level + 1, curent, max_value]
