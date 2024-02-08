extends Area2D

@onready var explosion_timer = $ExplosionTimer

@export var speed = 200
##How many times juuso can grow
@export var max_growth = 10
@export var growth_tracker = 0
var timer_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.x += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Food or Burgund_Stew:
		if area != korvip1:
			area.die()
			eat_food()
		if !timer_started:
			print("timer starting")
			timer_started = true
			explosion_timer.start() 
	if area is Boss:
		queue_free()
		#kutistu for the meems?
	

func eat_food():
	if growth_tracker <= max_growth:
		scale *= 1.15
		growth_tracker += 1


func _on_explosion_timer_timeout():
	print("timer finished")
	queue_free()
