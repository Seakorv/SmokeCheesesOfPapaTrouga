extends Node2D

@export var foodScenes: Array[PackedScene] = []

@onready var player_spawn = $SpawnPosition
@onready var pepe_make_ase = $PepeMakeAse
@onready var timer1 = $foodSpawnTimerOne
@onready var food_container = $FoodContainer

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


##Timer for first food spawns before Rixa
func _on_food_spawn_timer_one_timeout():
	var which_food = choose_not_so_randomly_from_seven(30, 10, 30, 15, 8, 6, 1)
	var food = foodScenes[which_food].instantiate()
	food.global_position = Vector2(2000, randf_range(50, 1030))
	food_container.add_child(food)


## Giving an int from zero to six, which food will be chosen. Give percentages in parameters. Don't exeed 100 lol
func choose_not_so_randomly_from_seven(olives: int, jelly_onions: int, meatballs: int, wieners: int, kebab: int, mandarin: int, golden_meatball: int):
	var chosen = 0
	var chooser = randi_range(0, 100)
	
	var o = olives
	var jl = jelly_onions + o
	var mb = jl + meatballs
	var w = mb + wieners
	var k = w + kebab
	var m = mandarin + k
	var gmb = m + golden_meatball
	
	if chooser <= o: return 0
	if chooser > o and chooser <= jl: return 1
	if chooser > jl and chooser <= mb: return 2
	if chooser > mb and chooser <= w: return 3
	if chooser > w and chooser <= k: return 4
	if chooser > k and chooser <= m: return 5
	if chooser > m and chooser <= gmb: return 6
	
