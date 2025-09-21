extends Control
class_name UIOverley
@onready var progress_bar: ProgressBar = $ProgressBar


func _ready() -> void:
	GlobalInfo.combat_ui_overlay = self


func update_progres_bar(curent: int, max_value: int):
	progress_bar.value = curent
	progress_bar.max_value = max_value
