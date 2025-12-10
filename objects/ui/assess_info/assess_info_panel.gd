extends Control
class_name AssessInfoPanel

@export var assess_manager: AssessManagerClass


func _ready() -> void:
	%AssessInfo.setup(assess_manager)


func _on_button_back_pressed() -> void:
	queue_free()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		queue_free()
