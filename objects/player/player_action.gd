@abstract
extends Node2D
class_name PlayerAction

@export_custom(PROPERTY_HINT_INPUT_NAME, "") var action: String
@export var player: Player
@export var repeat: bool = false

var cooldown: Timer

var player_action: bool = false:
	set(val):
		player_action = val

		if player_action and cooldown.is_stopped():
			do_execute_action()


func _ready() -> void:
	cooldown = Timer.new()
	cooldown.one_shot = true
	add_child(cooldown)
	cooldown.timeout.connect(do_execute_action)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(action):
		player_action = true

	if event.is_action_released(action):
		player_action = false


@abstract func get_cooldown()


@abstract func execute_action()


func do_execute_action():
	if not Input.is_action_pressed(action):
		player_action = false
		return

	execute_action()

	cooldown.wait_time = get_cooldown()
	cooldown.start()
