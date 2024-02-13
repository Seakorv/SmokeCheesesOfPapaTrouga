class_name Rixa extends Boss

signal jotunn_shot(jotunn_scene, location)

@onready var shoot_timer = $ShootTimer
@onready var jotunn_ase = $Jotunn_ase
@onready var muzzle = $Muzzletun

## Boss health
@export var health = 20
## Boss vector speed
@export var speed = 500


var jotunn_scene = preload("res://Scenes/rixa_bullet.tscn")


func _on_shoot_timer_timeout():
	jotunn_shot.emit(jotunn_scene, muzzle.global_position)


func im_hurt(damage):
	health -= damage
	if health <= 0:
		death()


func death():
	queue_free()
	boss_explosion()
	is_dead = true
	dying_event.emit(is_dead)
	shoot_timer.stop()

