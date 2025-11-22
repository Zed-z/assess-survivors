extends Node2D
class_name BasicShooter

@export var projectile: PackedScene
@export var shoot_coldown: float
@onready var timer: Timer = $Timer
@export var projectile_speed :int = 40
@export var damage : int = 1


func _ready() -> void:
	timer.wait_time = shoot_coldown
	timer.start()
	timer.timeout.connect(shoot_projectile)


func shoot_projectile():
	var dir = (GlobalInfo.player.global_position - global_position).normalized() * projectile_speed
	var proj: ProjectileEnemy = projectile.instantiate()
	proj.initiate_projectile(dir)
	proj.damage = damage
	proj.global_position = global_position
	GlobalInfo.projectile_holder.add_child(proj)
