extends Node2D

@export var foodScenes: Array[PackedScene] = []
@export var bossScenes: Array[PackedScene] = []
## How many geenades does PapaT have?
@export var how_many_geenades := 10


@onready var player_spawn = $SpawnPosition
@onready var pepe_make_ase = $PepeMakeAse
@onready var timer1 = $FoodSpawnTimerOne
@onready var timer2 = $FoodSpawnTimerTwo
@onready var timer3 = $FoodSpawnTimerThree
@onready var timer4 = $FoodSpawnTimerFour
@onready var timer5 = $FoodSpawnTimerFive
@onready var food_container = $FoodContainer
@onready var boss_container = $BossContainer
@onready var hud = $UILayer/HUD

var score := 0:
	set(value):
		score = value
		hud.score = score
var how_many_food := 0
var player = null
var boss = null


func _ready():
	hud.score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn.global_position
	player.pepeM_shot.connect(_on_player_gee_shot)  
	player.geenade_thrown.connect(_on_player_gee_thrown)
	player.juuso_thrown.connect(_on_player_juuso_thrown)


func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_player_gee_shot(gee_scene, location):
	var gee = gee_scene.instantiate()
	gee.global_position = location
	pepe_make_ase.add_child(gee)


func _on_player_gee_thrown(gee_nade_scene, location):
	if how_many_geenades > 0:
		how_many_geenades -= 1
		var geenade = gee_nade_scene.instantiate()
		geenade.global_position = location
		geenade.geexplode.connect(_on_geexplosion)
		pepe_make_ase.add_child(geenade)


func _on_geexplosion(explosion_scene, location):
	var geexplosion = explosion_scene.instantiate()
	geexplosion.global_position = location
	pepe_make_ase.add_child(geexplosion)


func _on_player_juuso_thrown(juuso_scene, location):
	if player.golden_juusos > 0:
		var juuso = juuso_scene.instantiate()
		juuso.global_position = location
		pepe_make_ase.add_child(juuso)
		player.golden_juusos -= 1


#Timer for first food spawns before Rixa
func _on_food_spawn_timer_one_timeout():
	#test
	#if how_many_food == 0:
		#spawn_juuso()
		#spawn_boss(1)
		#timer1.stop()
		#timer5.start()
		#spawn_juuso()
		#spawn_stew(1)
		#spawn_final_scene()
		#spawn_stew_wall()
	# 
	how_many_food += 1
	spawn_food(30, 10, 30, 15, 8, 6, 1, 1)
	if how_many_food == 10: 
		spawn_stew(1)
	if how_many_food == 20: #20
		timer1.stop()
		spawn_boss(1)
		how_many_food = 0
					

# function for food spawn. Give percentages for food and final double is the speed multiplier to adjust food speed.
func spawn_food(olives: int, jelly_onions: int, meatballs: int, wieners: int, kebab: int, mandarin: int, golden_meatball: int, speedmultiplier):
	var which_food = choose_not_so_randomly_from_seven(olives, jelly_onions, meatballs, wieners, kebab, mandarin, golden_meatball)
	var food = foodScenes[which_food].instantiate()
	food.food_eaten.connect(_on_food_eaten)
	food.speed_multiplier = speedmultiplier
	food.global_position = food_spawn_location()
	food_container.add_child(food)


func _on_food_eaten(points):
	score += points
	print(score)


# Spawn boss by its index. 0 is burgund stew, 1 is Rixa etc. Dont use this to call stews on testing.
func spawn_boss(boss_index):
	boss = bossScenes[boss_index].instantiate()
	boss.dying.connect(_boss_death)
	boss_container.add_child(boss)
		

func spawn_final_scene():
	var scene = bossScenes[5].instantiate()
	scene.game_finished.connect(_on_game_finished)
	boss_container.add_child(scene)


func _on_game_finished(points):
	score += points
	print(score)


func _boss_death(is_dead, points):
	how_many_geenades += 3
	if is_dead: #Relic from a time i didn't know you could emit signals without parameters and do not have the motivation to clean up yet
		score += points
		print(score)
		timer_starter(boss.get_index()+1)
	


# Giving an int from zero to six, which food will be chosen. Give percentages in parameters. Don't exeed 100 lol
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
	

# function to spawn burgund stew
func spawn_stew(how_fast):
	var stew = bossScenes[0].instantiate()
	stew.speed_multiplier = how_fast
	stew.global_position = food_spawn_location()
	stew.killed.connect(_on_stew_killed)
	food_container.add_child(stew)


func _on_stew_killed(points):
	score += points
	print(score)


func food_spawn_location():
	return Vector2(2000, randf_range(50,1030))


func spawn_juuso():
	var gjuuso = foodScenes[7].instantiate()
	gjuuso.global_position = food_spawn_location()
	food_container.add_child(gjuuso)


func timer_starter(which_timer):
	var timers_array = [timer1, timer2, timer3, timer4, timer5]
	timers_array[which_timer].start()  


func _on_food_spawn_timer_two_timeout():
	how_many_food += 1  
	spawn_food(33, 12, 25, 15, 8, 6, 1, 1.1)
	if how_many_food == 20 or how_many_food == 40: 
		spawn_stew(1.3)
	if how_many_food == 50: #50
		timer2.stop()
		spawn_boss(2)
		how_many_food = 0


func _on_food_spawn_timer_three_timeout():
	how_many_food += 1
	spawn_food(35, 15, 20, 13, 8, 6, 3, 1.3)
	if how_many_food == 20:
		spawn_stew(1.3)
	if how_many_food == 50:
		for n in 2:
			spawn_stew(1.5)
	if how_many_food == 90:
		for n in 3:
			spawn_stew(1.7)
	if how_many_food == 100: #100
		timer3.stop() 
		spawn_boss(3)
		how_many_food = 0


func _on_food_spawn_timer_four_timeout():
	how_many_food += 1
	spawn_food(40, 20, 15, 10, 5, 7, 3, 1.45)
	if how_many_food == 10:
		spawn_food_wall(2, 1)
		for n in 4:
			spawn_stew(2)
	if how_many_food == 30:
		spawn_juuso()
	if how_many_food == 70:
		spawn_food_wall(1, 0.5)
		for n in 5:
			spawn_stew(2)
	if how_many_food == 100:
		spawn_food_wall(2, 0.5)
	if how_many_food == 140:
		for n in 6:
			spawn_stew(2)
	if how_many_food == 155: #155
		timer4.stop()
		spawn_boss(4)
		how_many_food = 0


func _on_food_spawn_timer_five_timeout():
	how_many_food += 1
	if how_many_food < 200:
		spawn_food(45,25,10,5,5,5,5,1.6)
	if how_many_food == 5:
		spawn_food_wall(0, 0.7)
	if how_many_food == 20:
		for n in 3:
			spawn_stew(2)
	if how_many_food == 30:
		spawn_juuso()
	if how_many_food == 50:
		spawn_food_wall(2, 2)
	if how_many_food == 70:
		for n in 5:
			spawn_stew(2)
	if how_many_food == 90:
		spawn_food_wall(1, 1.5)
	if how_many_food == 120:
		spawn_food_wall(1, 1.3)
	if how_many_food == 140:
		spawn_food_wall(0, 1.5)
	if how_many_food == 150:
		spawn_juuso()
	if how_many_food == 170:
		spawn_stew_wall()
	if how_many_food >= 200:
		pass
	if how_many_food == 250:
		timer5.stop()
		spawn_final_scene()
		how_many_food = 0

#function which spawns a food wall with 500 food units. which_food is the index which will choose the food and speedmultiplier is self explanatory
func spawn_food_wall(which_food, speedmultiplier):
	for n in 500:
		var foodwallfood = foodScenes[which_food].instantiate()
		foodwallfood.food_eaten.connect(_on_food_eaten)
		foodwallfood.speed_multiplier = speedmultiplier
		foodwallfood.global_position = food_spawn_location()
		food_container.add_child(foodwallfood)


func spawn_stew_wall():
	var particles := 0
	for n in 1000:
		particles += 1
		var stew = bossScenes[0].instantiate()
		if particles % 10 != 0:
			stew.want_particles = false
		stew.speed_multiplier = 0.8
		stew.global_position = food_spawn_location()
		stew.killed.connect(_on_stew_killed)
		food_container.add_child(stew)
