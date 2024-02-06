extends Node2D

signal dying(is_dead)

@onready var korv_spawn = $SeakorvSpawn
@onready var korvi = $Path2D/PathFollow2D/Seakorv
@onready var modulator_timer = $ModulatorTimer
@onready var bullet_container = $Olive_container
@onready var mini_boss_container = $MiniBossContainer
@onready var teleport_timer = $TeleportTimer
@onready var thin_spawner_timer = $ThinSpawnerTimer
@onready var thin_spawn = $ThiniSpawn
@onready var korvi_path = $Path2D/PathFollow2D


## Seakorv teleport places during burgundshooting. Its always 3/4 y and teleports in the middle +- 270y
@export var teleport_places: Array[Vector2] = [Vector2(1550, 600), Vector2(1550, 870), Vector2(1550, 330)]
@export var mini_boss_scenes: Array[PackedScene] = []
var teleport_places_size = teleport_places.size()

var shoot_burgund = false
var teleport_counter = 0
var modulate_counter = 0
var minithin_counter = 0
var korvi_r = 1
var korvi_g = 1
var korvi_b = 1
var tele_index = 0
var tele_prev_index = 0
var is_korvi_child = false

# Called when the node enters the scene tree for the first time.
func _ready():
	korvi.global_position = korv_spawn.global_position
	korvi.olives_shot.connect(_on_olives_shot)
	korvi.burgund_shot.connect(_on_burgund_shot)
	korvi.olives_has_been_shot.connect(_korvi_start_teleports)
	korvi.dying_event.connect(_on_korvi_death)
	#thin_spawner_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_olives_shot(olive_scene, location):
	var olives = olive_scene.instantiate()
	olives.global_position = location
	bullet_container.add_child(olives)


func _on_burgund_shot(burgund_scene, location):
	var burgund = burgund_scene.instantiate()
	burgund.speed = 1000
	burgund.global_position = location
	bullet_container.add_child(burgund)


func _on_korvi_death(is_boss_dead):
	dying.emit(is_boss_dead)
	

func _korvi_start_teleports(start_teleports):
	teleport_timer.start()
	#korvi_path.remove_child(korvi)
	#add_child(korvi)

func spawn_mini_boss(index):
	var miniboss = mini_boss_scenes[index].instantiate()
	miniboss.global_position = Vector2(0, 0)
	mini_boss_container.add_child(miniboss)
	

func _mini_boss_death(is_dead):
	pass
	

func make_korvi_child(is_korvi_child):
	if !is_korvi_child:
		#print("korvi lapsetetaan")
		korvi_path.remove_child(korvi)
		add_child(korvi)
	elif is_korvi_child:
		#print("päästiin tänne")
		korvi.position = Vector2(0,0)
		remove_child(korvi)
		korvi_path.add_child(korvi)
		


func _on_teleport_timer_timeout():
	if teleport_counter <= 4:
		teleport_counter += 1
		tele_prev_index = tele_index
		while tele_prev_index == tele_index:
			tele_index = randi_range(0, teleport_places_size)
		modulator_timer.start()
		if !is_korvi_child:
			make_korvi_child(is_korvi_child)
			is_korvi_child = true
		korvi.position = teleport_places[tele_index-1]
	if teleport_counter >= 5:
		modulator_timer.stop()
		teleport_counter = 0
		teleport_timer.stop()
		thin_spawner_timer.start()
		korvi.olive_timer.start()
		make_korvi_child(is_korvi_child)
		is_korvi_child = false
	

func _on_modulator_timer_timeout():
	modulate_counter += 1
	korvi_r += 0.1
	korvi_g += 0.1
	korvi_b += 0.1
	korvi.modulate = Color(korvi_r, korvi_g, korvi_b)
	if modulate_counter == 27: #kutsu täällä padat
		modulator_timer.stop()
		modulate_counter = 0
		korvi_r = 1 
		korvi_g = 1
		korvi_b = 1
		korvi.modulate = Color(korvi_r, korvi_g, korvi_b)
		shoot_burgund = true
		korvi.burgund_timer.start()
		shoot_burgund = false


func _on_thin_spawner_timer_timeout():
	minithin_counter += 1
	spawn_mini_boss(0)
	if minithin_counter >= 3:
		minithin_counter = 0
		thin_spawner_timer.stop()
	
