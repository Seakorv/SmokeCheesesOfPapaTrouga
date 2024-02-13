class_name PapaT extends CharacterBody2D

signal pepeM_shot(gee_scene, location)
signal geenade_thrown(gee_nade_scene, location)
signal juuso_thrown(juuso_scene, location)

const SPEED = 1000.0

@onready var muzzle = $Muzzle
@onready var geenadejuuso_muzzle = $GeeJuusoMuzzle
@onready var healthbar = $hpBar
## Player health
@export var maxHealth = 1000
var health = maxHealth
var golden_juusos = 0

var gee_scene = preload("res://Scenes/gee_bullet.tscn")
var gee_nade_scene = preload("res://Scenes/gee_nade.tscn")
var juuso_scene = preload("res://Scenes/juuso_kevennys.tscn")
var explosion = preload("res://Scenes/papa_explosion_particle.tscn")

func _process(delta):
	if Input.is_action_just_pressed("shoot_pepemake"):
		shoot()
	if Input.is_action_just_pressed("shoot_geenade"):
		throw_gee()
	if Input.is_action_just_pressed("shoot_juuso"):
		throw_juuso()

func _physics_process(delta):

	#creating the health bar
	update_health()
	
	# Movement with vector2
	var direction = Vector2(0, Input.get_axis("move_up", "move_down"))
	velocity = direction * SPEED
	move_and_slide()
	
	#restricting player movement into the screen
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)


func update_health():
	healthbar.value = health


## updating health
func take_damage_or_heal(damage):
	health += damage
	if health >= maxHealth:
		health = maxHealth
	if health <= 0:
		die()


func shoot():
	pepeM_shot.emit(gee_scene, muzzle.global_position)


func throw_gee():
	geenade_thrown.emit(gee_nade_scene, geenadejuuso_muzzle.global_position)


func throw_juuso():
	juuso_thrown.emit(juuso_scene, geenadejuuso_muzzle.global_position)


func die():
	papa_explosion()
	queue_free()


func papa_explosion():
	#print("pum")
	var _particle = explosion.instantiate()
	_particle.position = global_position
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
