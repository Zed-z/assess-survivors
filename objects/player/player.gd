extends CharacterBody2D
class_name Player

@export var SPEED:float = 200.0

@onready var stats = $Stats

var last_direction: int = 1


func _ready() -> void:
	$HealthComponent.setup($Stats.stats["STAT_HP"].get_stat())

	GlobalInfo.combat_ui_overlay.health_bar.setup($HealthComponent.current_health, $HealthComponent.health)
	$HealthComponent.health_changed.connect(GlobalInfo.combat_ui_overlay.health_bar.set_health)
	$HealthComponent.max_health_changed.connect(GlobalInfo.combat_ui_overlay.health_bar.set_max_health)
	GlobalInfo.combat_ui_overlay.stat_panel.data_fill(stats.stats.values())

	stats.get_stat_raw("STAT_HP").value_changed.connect($HealthComponent.new_max_health)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("game_left","game_right","game_up","game_down").normalized()
	direction.y *= 0.75
	velocity = direction * SPEED;

	if velocity.x > 0:
		last_direction = 1
	elif velocity.x < 0:
		last_direction = -1

	$Sprite2D.scale.x = last_direction

	if velocity.length() > 0:
		$Sprite2D/PlayerSprite.animation = "walk"
	else:
		$Sprite2D/PlayerSprite.animation = "idle"

	move_and_slide()


func _on_levels_new_level(level: int) -> void:
	GlobalInfo.score_manager.score_increase(1000)
	var choice_panel: ChoicePanel = ObjectManager.instantiate(ObjectManager.OBJ_CHOICE_PANEL)
	choice_panel.criterion = GlobalInfo.assess_manager.get_criterion()
	choice_panel.question = choice_panel.criterion.get_question()
	GlobalInfo.combat_ui_overlay.add_child(choice_panel)


func _on_health_component_got_hit(depleted: bool) -> void:
	print("hit")
	GlobalInfo.game_camera.shake()

	if depleted:
		print("You Died")
		var end_screen: EndScreen = ObjectManager.instantiate(ObjectManager.OBJ_END_SCREEN)
		GlobalInfo.combat_ui_overlay.add_child(end_screen)
