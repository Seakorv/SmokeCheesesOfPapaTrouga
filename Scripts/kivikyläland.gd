extends Node2D

@onready var player_spawn = $SpawnPosition
@onready var pepe_make_ase = $PepeMakeAse

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn.global_position
	player.pepeM_shot.connect(_on_player_gee_shot)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_gee_shot(gee_scene, location):
	var gee = gee_scene.instantiate()
	gee.global_position = location
	pepe_make_ase.add_child(gee)
