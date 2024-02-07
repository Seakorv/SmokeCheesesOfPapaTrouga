class_name Jotunn_ball extends BossAmmo

@export var speed = 300


func _physics_process(delta):
	global_position.x += -speed * delta

	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body is PapaT:
		body.die()
		queue_free()
