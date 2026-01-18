extends Node
class_name PauseManagerClass

var tree_paused: bool = false:
	set(val):
		tree_paused = val
		get_tree().paused = tree_paused
var pause_counter = 0


func pause():
	pause_counter += 1
	apply_pause()


func unpause():
	pause_counter -= 1
	apply_pause()


func apply_pause():
	assert(pause_counter >= 0, "Too many unpauses")
	tree_paused = pause_counter > 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
