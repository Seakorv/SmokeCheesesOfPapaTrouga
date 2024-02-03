class_name Rixa extends Boss

signal jotunn_shot(jotunn_scene, location)
signal dying_event(is_dead)

@onready var shoot_timer = $ShootTimer
@onready var jotunn_ase = $Jotunn_ase
@onready var muzzle = $Muzzletun

## Boss health
@export var health = 20
## Boss vector speed
@export var speed = 500
## How many points will boss' death give
@export var score = 1000
@export var tag = "Rixa"


var jotunn_scene = preload("res://Scenes/rixa_bullet.tscn")


func _on_shoot_timer_timeout():
	jotunn_shot.emit(jotunn_scene, muzzle.global_position)


func im_hurt():
	health -= 1
	if health <= 0:
		death()


func death():
	queue_free()
	is_dead = true
	dying_event.emit(is_dead)
	shoot_timer.stop()

