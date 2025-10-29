extends Control

class_name StatPanelItem

var stat: BaseStat


func data_fill(val: float) -> void:
	%StatLabel.text = tr(stat.name) + " : " + "%0.2f" % val


func _ready():
	%StatIcon.texture = stat.icon
	data_fill(stat.value)
	stat.value_changed.connect(data_fill)
