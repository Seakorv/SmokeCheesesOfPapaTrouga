class_name Food extends Area2D

@export var speed = 500


func _physics_process(delta):
	global_position.x += -speed * delta


func die():
	queue_free()
	

func _on_body_entered(body):
	if body is PapaT:
		die()
