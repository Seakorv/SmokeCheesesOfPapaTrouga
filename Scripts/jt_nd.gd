class_name Jt extends Boss

@export var health = 50
@export var speed = 1000

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