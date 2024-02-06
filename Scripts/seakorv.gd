class_name Seakorv extends Boss

var olive_scene = preload("res://Scenes/olives.tscn")

signal olives_shot(olive_scene, location)

@export var health = 200

@onready var olive_timer = $OliveTimer
@onready var oliveAseMuzzle = $Muzzzle1
@onready var ase2 = $Muzzzle2

## variable to define olive shooting bursts, like boss "smiq" shoots.
@export var olive_shoot_pacing = 0
## variable to count how many olive burst have been shot. Counter rises just before new burst.
@export var olive_burst_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func im_hurt():
	health -= 1
	if health <= 0:
		death()
		

func death():
	queue_free()
	is_dead = true
	dying_event.emit(is_dead)
	

func _on_olive_timer_timeout():
	olive_shoot_pacing += 1
	if olive_shoot_pacing <= 25:
		olives_shot.emit(olive_scene, oliveAseMuzzle.global_position)
	if olive_shoot_pacing >= 50:
		olive_burst_counter += 1
		olive_shoot_pacing = 0
	if olive_burst_counter == 5:
		olive_timer.stop()
