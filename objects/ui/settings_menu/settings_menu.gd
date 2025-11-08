@tool
extends Control

@export var show_game_tab: bool = false

@onready var tab_bar: TabBar = $TabBar
@onready var content_panel: Control = $Panel  # or whatever node contains your pages
var tab_contents: Array[SettingsTab] = []


func _populate_tabs():
	tab_bar.clear_tabs()
	for tab: SettingsTab in tab_contents:
		tab_bar.add_tab(tab.tab_name)


func _on_tab_selected(tab_index: int):
	_show_tab(tab_index)


func _show_tab(index: int):
	for i in range(len(tab_contents)):
		tab_contents[i].visible = (i == index)

var close_callback: Callable


func close() -> void:
	queue_free()
	if close_callback:
		close_callback.call()


func tab_prev() -> void:
	if $TabBar.current_tab > 0:
		$TabBar.current_tab -= 1

	$TabBar.grab_focus()


func tab_next() -> void:
	if $TabBar.current_tab < $TabBar.get_tab_count() - 1:
		$TabBar.current_tab += 1

	$TabBar.grab_focus()


func _ready() -> void:

	get_tree().paused = true

	for child: SettingsTab in content_panel.get_children():
		if not show_game_tab and child == $Panel/Game:
			child.queue_free()
			continue

		tab_contents.append(child)

	tab_bar.tab_selected.connect(_on_tab_selected)
	_populate_tabs()
	_show_tab(0)

	$TabBar.grab_focus()


func _on_close_button_pressed() -> void:
	close()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close()

	if event.is_action_pressed("ui_page_up"):
		tab_prev()

	if event.is_action_pressed("ui_page_down"):
		tab_next()


func _on_tree_exiting() -> void:
	get_tree().paused = false
