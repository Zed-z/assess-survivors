extends Control


var close_callback: Callable


func close() -> void:
	queue_free()
	close_callback.call()


func tab_prev() -> void:
	if $TabContainer.current_tab > 0:
		$TabContainer.current_tab -= 1


func tab_next() -> void:
	if $TabContainer.current_tab < $TabContainer.get_tab_count() - 1:
		$TabContainer.current_tab += 1


func _ready() -> void:
	$TabContainer/General/Button.grab_focus()


func _on_close_button_pressed() -> void:
	close()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close()
	if event.is_action_pressed("ui_page_up"):
		tab_prev()
	if event.is_action_pressed("ui_page_down"):
		tab_next()
