extends Area2D

@export var speed = 1000


func _physics_process(delta):
	global_position.x += speed * delta

	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Food:
		area.die()
		queue_free()
	if area is Boss:
		area.im_hurt(1)
		queue_free()
	if area is Jotunn_ball:
		queue_free()
	if area is Burgund_Stew:
		area.take_damage(1)
		queue_free()
