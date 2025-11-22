extends Area2D
class_name BaseHurtbox

signal hit(parameters: DamageParameters)


func _ready():
	pass


func got_hit(params: DamageParameters):
	hit.emit(params)
	print("hit")
