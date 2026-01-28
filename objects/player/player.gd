extends CharacterBody2D
class_name Player

@onready var scene: GameplayScene = get_parent()
@onready var stats: PlayerStats = $Stats

@export var ENDGAMELEVEL = 10
var last_direction: int = 1

var speed: float


func set_speed(spd: float) -> void:
	speed = spd


func _ready() -> void:
	GlobalInfo.player = self

	$HealthComponent.setup(stats.get_stat("STAT_HP"))

	GlobalInfo.combat_ui_overlay.health_bar.setup($HealthComponent.current_health, $HealthComponent.health)
	$HealthComponent.health_changed.connect(GlobalInfo.combat_ui_overlay.health_bar.set_health)
	$HealthComponent.max_health_changed.connect(GlobalInfo.combat_ui_overlay.health_bar.set_max_health)
	GlobalInfo.combat_ui_overlay.stat_panel.data_fill(stats.values())

	stats.get_stat_raw("STAT_HP").value_changed.connect($HealthComponent.new_max_health)

	speed = stats.get_stat_raw("STAT_SPD").value
	stats.get_stat_raw("STAT_SPD").value_changed.connect(set_speed)


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("game_left","game_right","game_up","game_down").normalized()
	direction.y *= 0.75
	velocity = direction * speed;

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
	GlobalInfo.combat_ui_overlay.add_child(
		GlobalInfo.assess_manager.init_choice_panel())


func _on_health_component_got_hit(depleted: bool) -> void:
	print("hit")
	GlobalInfo.game_camera.shake_scalable()

	if depleted:
		print("You Died")
		scene.game_end()
