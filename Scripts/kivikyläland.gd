extends Node2D

@export var foodScenes: Array[PackedScene] = []
@export var bossScenes: Array[PackedScene] = []

@onready var player_spawn = $SpawnPosition
@onready var pepe_make_ase = $PepeMakeAse
@onready var timer1 = $FoodSpawnTimerOne
@onready var timer2 = $FoodSpawnTimerTwo
@onready var food_container = $FoodContainer
@onready var boss_container = $BossContainer


var how_many_food = 0
var player = null
var boss = null



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
	##test
	#if how_many_food == 0:
	#	spawn_boss(2)
	#	timer1.stop()
	##
	how_many_food += 1
	spawn_food(30, 10, 30, 15, 8, 6, 1, 1)
	if how_many_food == 10: 
		spawn_stew(1)
	if how_many_food == 20:
		timer1.stop()
		spawn_boss(1)
		how_many_food = 0
					

## function for food spawn. Give percentages for food and final double is the speed multiplier to adjust food speed.
func spawn_food(olives: int, jelly_onions: int, meatballs: int, wieners: int, kebab: int, mandarin: int, golden_meatball: int, speedmultiplier):
	var which_food = choose_not_so_randomly_from_seven(olives, jelly_onions, meatballs, wieners, kebab, mandarin, golden_meatball)
	var food = foodScenes[which_food].instantiate()
	food.speed_multiplier = speedmultiplier
	food.global_position = food_spawn_location()
	food_container.add_child(food)


## Spawn boss by its index. 0 is burgund stew, 1 is Rixa etc.
func spawn_boss(boss_index):
	boss = bossScenes[boss_index].instantiate()
	boss.dying.connect(_boss_death)
	boss_container.add_child(boss)
	

func _boss_death(is_dead):
	if is_dead:
		timer_starter(boss.get_index()+1)


## Giving an int from zero to six, which food will be chosen. Give percentages in parameters. Don't exeed 100 lol
func choose_not_so_randomly_from_seven(olives: int, jelly_onions: int, meatballs: int, wieners: int, kebab: int, mandarin: int, golden_meatball: int):
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
	

## function to spawn burgund stew
func spawn_stew(how_fast):
	var stew = bossScenes[0].instantiate()
	stew.speed_multiplier = how_fast
	stew.global_position = food_spawn_location()
	food_container.add_child(stew)
	

func food_spawn_location():
	return Vector2(2000, randf_range(50,1030))


func _on_food_spawn_timer_two_timeout():
	how_many_food += 1
	spawn_food(33, 12, 25, 15, 8, 6, 1, 1.1)
	if how_many_food == 20 or how_many_food == 40: 
		spawn_stew(1.3)
	if how_many_food == 50:
		timer2.stop()
		spawn_boss(2)
		how_many_food = 0
		

func timer_starter(which_timer):
	var timers_array = [timer1, timer2]
	timers_array[which_timer].start()
