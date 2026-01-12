extends Area2D
class_name BaseProjectile

var direction: Vector2
var damage: float

@export var speed: float = 1
@export var rotates: bool = true


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func initiate_projectile(vec: Vector2) -> void:
	direction = vec

	$Sprite2D.rotation = direction.angle()


func _physics_process(delta: float) -> void:
	position += direction * delta * speed

	if rotates:
		$Sprite2D.rotation += deg_to_rad(360) * delta


func _on_area_entered(area: Area2D) -> void:
	if area is AreaBounds:
		queue_free()
