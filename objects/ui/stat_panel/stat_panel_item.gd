extends Control

class_name StatPanelItem

var stat: BaseStat


func data_fill(val: float) -> void:
	%StatLabel.text = stat.name + ":" + "%0.2f" % val
	print(stat.name + ":" + "%0.2f" % val)


func ready():
	print("my stat is " + stat.name)
	stat.value_changed.connect(data_fill)
	data_fill(stat.value)
