extends BossAmmo

@export var speed = 600
## negative if does damage, positive if heals
@export var damage = -2


func _physics_process(delta):
	global_position.x += -speed * delta

	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body is PapaT:
		queue_free()
		body.take_damage_or_heal(damage)
