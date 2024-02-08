extends korvip1

var end_position
var korvi_position
var randomvecotr = Vector2(-500, 540)
var jt_next = false
## how many jt-like attacks does korvi do. Does half the amount of attacks than this number
@onready var how_many_eager_edges = 10
var eager_edge_counter = 0
var rotate_scale_counter = 0
@onready var jt_attack_timer = $JtAttack
@onready var prep_for_jt_timer = $PrepareforJtTimer
@onready var anti_prep_for_jt_timer = $PrepareforJtTimerAnti
@onready var mini_thini_death_timer = $MiniThiniDeathTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	korvi.p2death = true
	korvi.olives_shot.connect(_on_olives_shot)
	korvi.burgund_shot.connect(_on_burgund_shot)
	korvi.olives_has_been_shot.connect(_korvi_start_teleports)
	korvi.dying_event.connect(_on_korvi_death2)
	p2event.connect(_jt_attack)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if korvi != null and jt_next:
		end_position = randomvecotr
		korvi_position = (end_position - korvi.position).normalized()
		korvi.position += korvi_position * delta * korvi.speed


func _on_korvi_death2(is_boss_dead):
	dying.emit(is_boss_dead)
	golden_meatball_timer.stop()
	modulator_timer.stop()
	teleport_timer.stop()
	thin_spawner_timer.stop()
	jt_attack_timer.stop()
	prep_for_jt_timer.stop()
	anti_prep_for_jt_timer.stop()
	mini_thini_death_timer.start()

func _on_jt_attack_timeout():
	eager_edge_counter += 1
	korvi.global_position = Vector2(1550, 600)
	if eager_edge_counter % 2 == 1:
		randomvecotr = Vector2(1550, 600)
		korvi.position = randomvecotr
	if eager_edge_counter % 2 == 0:
		randomvecotr = random_vector()
	if eager_edge_counter == how_many_eager_edges-1:
		eager_edge_counter = 0
		#korvi.global_position = Vector2(1550, 600)
		jt_attack_timer.stop()
		anti_prep_for_jt_timer.start()
	


func _jt_attack():
	prep_for_jt_timer.start()
	
	

func random_vector():
	var x = -500
	var y = randi_range(-200, 1280)
	return Vector2(x, y)


func _on_preparefor_jt_timer_timeout():
	rotate_scale_counter += 1
	korvi.global_rotation += 0.01
	korvi.global_scale -= Vector2(0.01, 0.01)
	if rotate_scale_counter == 20:
		rotate_scale_counter = 0
		prep_for_jt_timer.stop()
		jt_next = true
		jt_attack_timer.start()
		randomvecotr = Vector2(-500, 540)


func _on_preparefor_jt_timer_anti_timeout():
	rotate_scale_counter += 1
	if rotate_scale_counter >= 20:
		korvi.global_rotation -= 0.01
		korvi.global_scale += Vector2(0.01, 0.01)
	if rotate_scale_counter == 40:
		rotate_scale_counter = 0
		anti_prep_for_jt_timer.stop()
		jt_next = false
		korvi.olive_timer.start()
		make_korvi_child()
		is_korvi_child = false


func _on_mini_thini_death_timer_timeout():
	var miniboss = mini_boss_scenes[0].instantiate()
	miniboss.global_position = Vector2(0, 0)
	mini_boss_container.add_child(miniboss)
