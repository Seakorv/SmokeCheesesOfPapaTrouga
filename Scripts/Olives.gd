class_name Olives extends Area2D

@export var speed = 750

func _physics_process(delta):
	global_position.x += -speed * delta
	

func die():
	queue_free()


func _on_body_entered(body):
	if body is PapaT:
		body.die()
		die()
