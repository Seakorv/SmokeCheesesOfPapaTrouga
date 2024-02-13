class_name Burgund_Stew extends Area2D

signal killed(points)
@onready var explosion = preload("res://Scenes/explosion_particle.tscn")

## Stew's health
@export var health = 10
## Stew's speed
@export var speed = 200
## Stew's speed modifier. Change this when the game gets harder
@export var speed_multiplier = 1
## How many points does the player get for killing this
@export var points = 100
var want_particles = true

func _physics_process(delta):
	global_position.x += -(speed * speed_multiplier) * delta


func die():
	if want_particles:
		burg_explosion()
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	if body is PapaT:
		body.die()
		

##Only take damage so the parameter damage should be always given positive. Although negative values would heal and work 
func take_damage(damage):
	health -= damage
	if health <= 0:
		killed.emit(points)
		die()


func burg_explosion():
	#print("pum")
	var _particle = explosion.instantiate()
	_particle.position = global_position
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
