class_name ThinBoi extends Veljekset_Li

signal lorenz_shot(lorenz_scene, location)

@onready var lorenz_timer = $LorenzTimer
@onready var muzzle = $Muzzle

var lorenz_scene = preload("res://Scenes/lorenz_bullet.tscn")


func _on_lorenz_timer_timeout():
	lorenz_shot.emit(lorenz_scene, muzzle.global_position)


func im_hurt(damage):
	health -= damage
	if health <= 0:
		death()


func death():
	queue_free()
	boss_explosion()
	lorenz_timer.stop()
	is_dead = true
	dying_event.emit(is_dead)
