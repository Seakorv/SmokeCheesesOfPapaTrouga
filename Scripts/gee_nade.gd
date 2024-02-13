extends Area2D

signal geexplode(explosion_scene, location)

@onready var explosion = preload("res://Scenes/gee_explosion_particle.tscn")
@onready var explosion_location = $ExplodeHere

@export var speed = 500
var explosion_scene = preload("res://Scenes/gee_nade_explosion.tscn")


func _physics_process(delta):
	global_position.x += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	

func _on_area_entered(area):
	if area is Food:
		area.die()
		explode()
	if area is Burgund_Stew:
		area.take_damage(2)
		explode()
	if area is Boss:
		area.im_hurt(3)
		explode()
	if area is BossAmmo:
		area.gee_nade_hits()
		explode()


func explode():
	geexplode.emit(explosion_scene, explosion_location.global_position)
	gee_explosion()
	queue_free()
	

func gee_explosion():
	#print("pum")
	var _particle = explosion.instantiate()
	_particle.position = global_position
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
