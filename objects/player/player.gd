extends CharacterBody2D
class_name Player

@export var SPEED:float = 300.0

@onready var stats = $Stats


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("game_left","game_right","game_up","game_down").normalized()
	direction.y *= 0.5
	velocity = direction * SPEED;

	move_and_slide()


func _on_levels_new_level(level: int) -> void:
	GlobalInfo.combat_ui_overlay.add_child(ObjectManager.instantiate(ObjectManager.OBJ_CHOICE_PANEL))
