extends Node2D

signal dying(is_dead)

@onready var boss = $Jt_nd
@onready var jt_spawn = $JtSpawn
@onready var timer = $JtEagerEdgeTimer
## Position where i want JT to arrive
var end_position
## JT's position
var boss_position
var randomvecotr = Vector2(-500, 540)
var timersplitter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	boss.global_position = jt_spawn.global_position
	boss.dying_event.connect(_on_boss_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if boss != null:
		end_position = randomvecotr
		boss_position = (end_position - boss.position).normalized()
		boss.position += boss_position * delta * boss.speed
	

func random_vector():
	var x = -500
	var y = randi_range(-200, 1280)
	return Vector2(x, y)


func _on_jt_eager_edge_timer_timeout():
	timersplitter += 1
	boss.global_position = jt_spawn.global_position
	if timersplitter == 1:
		randomvecotr = jt_spawn.global_position
		boss.position = randomvecotr
	
	if timersplitter == 2:
		randomvecotr = random_vector()
		timersplitter = 0


func _on_boss_death(is_boss_dead):
	dying.emit(is_boss_dead)
	boss = null
	timer.stop()
