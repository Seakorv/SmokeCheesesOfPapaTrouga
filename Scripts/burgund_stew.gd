class_name Burgund_Stew extends Area2D

## Stew's health
@export var health = 10
## Stew's speed
@export var speed = 200
## Stew's speed modifier. Change this when the game gets harder
@export var speed_multiplier = 1
## How many points does the player get for killing this
@export var points = 100

func _physics_process(delta):
	global_position.x += -(speed * speed_multiplier) * delta


func die():
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body is PapaT:
		body.die()
		

func take_damage():
	health -= 1
	if health <= 0:
		die()
