@tool
extends Control

@onready var tab_bar: TabBar = $TabBar
@onready var content_panel: Control = $Panel  # or whatever node contains your pages


func _populate_tabs():
	tab_bar.clear_tabs()
	for child: SettingsTab in content_panel.get_children():
		tab_bar.add_tab(child.tab_name)


func _on_tab_selected(tab_index: int):
	_show_tab(tab_index)


func _show_tab(index: int):
	var children = content_panel.get_children()

	for i in range(len(children)):
		children[i].visible = (i == index)

var close_callback: Callable


func close() -> void:
	queue_free()
	if close_callback != null:
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
