class_name Boss extends Area2D

@onready var explosion = preload("res://Scenes/explosion_particle.tscn")
var is_dead = false
signal dying_event(is_dead)


func die():
	pass


func boss_explosion():
	print("pum")
	var _particle = explosion.instantiate()
	_particle.position = global_position
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
