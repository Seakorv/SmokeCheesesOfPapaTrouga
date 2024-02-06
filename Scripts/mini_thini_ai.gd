extends Node2D

@onready var mini_thin = $MiniThiniBoi
@onready var thin_port_timer = $ThinPortTimer
@onready var lorenz_container = $LorenzContainer
var mini_thin_dead = false

signal dying(is_dead)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	mini_thin.dying_event.connect(_on_mini_thin_death)
	mini_thin.lorenz_shot.connect(_on_mini_thin_lorenz_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func mini_thin_bakris():
	var x = randi_range(1000, 1600)
	var y = randi_range(50, 1030)
	mini_thin.position = Vector2(x, y)


func _on_thin_port_timer_timeout():
	mini_thin_bakris()


func _on_mini_thin_lorenz_shot(lorenz_scene, location):
	var lorenz_bullet = lorenz_scene.instantiate()
	lorenz_bullet.global_position = location
	lorenz_container.add_child(lorenz_bullet)
	

func _on_mini_thin_death(is_boss_dead):
	thin_port_timer.stop()
	mini_thin_dead = true
	dying.emit(is_boss_dead)

