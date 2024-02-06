extends Node2D

@export var scene_array: Array[PackedScene] = []
var current_scene

@onready var player = $PapaT
@onready var pepe_make_ase = $PepeMakeAse
#var cutscene = preload("res://Scenes/korv_phase_transition_cutscene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	player.pepeM_shot.connect(_on_player_gee_shot)  
	current_scene = scene_array[0].instantiate()
	add_child(current_scene)
	#if scenecounter == 0:
	current_scene.anim_player.animation_finished.connect(_scene1_done)
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _scene1_done(anim_finished): 
	current_scene.queue_free()
	current_scene = scene_array[1].instantiate()
	add_child(current_scene)
	current_scene.dying.connect(_scene2_done)

func _scene2_done(is_boss_dead):
	current_scene.queue_free()
	current_scene = scene_array[2].instantiate()
	add_child(current_scene)
	current_scene.anim_player.animation_finished.connect(_scene3_done)

func _scene3_done(anim_finished):
	current_scene.queue_free()
	current_scene = scene_array[3].instantiate()
	add_child(current_scene)
	current_scene.dying.connect(_scene4_done)


func _scene4_done(is_boss_deads):
	pass


func _on_player_gee_shot(gee_scene, location):
	var gee = gee_scene.instantiate()
	gee.global_position = location
	pepe_make_ase.add_child(gee)
