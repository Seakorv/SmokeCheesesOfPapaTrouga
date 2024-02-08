class_name Food extends Area2D

## The speed of the food
@export var speed = 500
## Is the food good or bad. Write "good" or "bad"
@export var goodOrBad = ""
## How much damage does the food do? Positive if it heals, negative if it hurts
@export var damage = 0
## How much score does the food give?
@export var points = 0
## Speed variable which can be changed. Multiples the base speed. Give something like 1.5 for the value.
@export var speed_multiplier = 1

func _physics_process(delta):
	global_position.x += -(speed * speed_multiplier) * delta


func die():
	queue_free()
	

func _on_body_entered(body):
	if body is PapaT:
		die()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
