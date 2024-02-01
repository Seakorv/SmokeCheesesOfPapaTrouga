extends CharacterBody2D

signal pepeM_shot(gee_scene, location)

const SPEED = 1000.0

@onready var muzzle = $Muzzle

var gee_scene = preload("res://Scenes/gee_bullet.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot_pepemake"):
		shoot()

func _physics_process(delta):

	# Restricting character movement into the screen

	# Movement with vector2
	var direction = Vector2(0, Input.get_axis("move_up", "move_down"))
	velocity = direction * SPEED
	move_and_slide()

func shoot():
	pepeM_shot.emit(gee_scene, muzzle.global_position)
