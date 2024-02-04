extends Node2D

@onready var boss = $Jt_nd
@onready var jt_spawn = $JtSpawn
var movement_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	boss.global_position = jt_spawn.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	

func eager_edge():
	var x = -1500
	var y = randi_range(500, -500)
	boss.position += Vector2(x, y)


func _on_jt_eager_edge_timer_timeout():
	eager_edge()
	movement_timer += 1
	if movement_timer == 2:
		boss.global_position = jt_spawn.global_position
		movement_timer = 0
