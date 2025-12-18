extends PanelContainer

class_name StatPanel
@export var stats: Array[BaseStat]
@export var item_display: PackedScene


func data_fill(stats_arr: Array[BaseStat]):
	stats = stats_arr

	for stat in stats:
		if stat.hidden:
			continue

		var x: StatPanelItem = item_display.instantiate()
		x.stat = stat
		%VBoxContainer.add_child(x)
