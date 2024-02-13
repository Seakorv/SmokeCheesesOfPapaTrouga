extends Node2D

@onready var thin = $ThiniBoi
@onready var thicc = $ThiccBoi
@onready var thin_spawn = $ThinSpawn
@onready var thin_port_timer = $ThinTeleportTimer
@onready var lorenz_container = $LorezContainer
var thin_dead = false
var thicc_dead = false

signal dying(is_dead, points)

@export var points := 2500

# Called when the node enters the scene tree for the first time.
func _ready():
	thin.dying_event.connect(_on_thin_death)
	thicc.dying_event.connect(_on_thicc_death)
	thin.global_position = thin_spawn.global_position
	thin.lorenz_shot.connect(_on_thin_lorenz_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_thin_death(is_boss_dead):
	thin_port_timer.stop()
	thin_dead = true
	if !thicc_dead:
		thicc.modulate = Color(1, 0, 0)
		thicc.damage *= 2
		thicc.speed *= 1.5
	else:
		dying.emit(is_boss_dead, points)


func _on_thicc_death(is_boss_dead):
	thicc_dead = true
	if !thin_dead:
		thin.modulate = Color(1, 0, 0)
		thin_port_timer.wait_time = 0.5
		thin.lorenz_timer.wait_time = 0.4
	else:
		dying.emit(is_boss_dead, points)

func thin_bakris():
	var x = randi_range(1200, 1800)
	var y = randi_range(50, 1030)
	thin.position = Vector2(x, y)


func _on_thin_teleport_timer_timeout():
	thin_bakris()


func _on_thin_lorenz_shot(lorenz_scene, location):
	var lorenz_bullet = lorenz_scene.instantiate()
	lorenz_bullet.global_position = location
	lorenz_container.add_child(lorenz_bullet)
