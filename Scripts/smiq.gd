class_name Smiq extends Boss

signal vex_shot(vex_scene, location)

@onready var shoot_timer = $ShootTimer
@onready var vex_ase = $Ase
@onready var muzzle = $Muzzle
## Variable to adjust how many bullets will smiq shoot before a break
var shootburst = 0

## Boss health
@export var health = 40
## Boss vector speed
@export var speed = 500


var vex_scene = preload("res://Scenes/vex_bullet.tscn")


func _on_shoot_timer_timeout():
	shootburst += 1
	if shootburst <= 7:
		vex_shot.emit(vex_scene, muzzle.global_position)
	if shootburst >= 10:
		shootburst = 0


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
