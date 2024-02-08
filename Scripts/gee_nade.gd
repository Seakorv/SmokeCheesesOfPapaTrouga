extends Area2D

signal geexplode(explosion_scene, location)

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
	queue_free()
