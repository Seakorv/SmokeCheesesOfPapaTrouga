class_name Jt extends Boss

@export var health = 50
@export var speed = 3000
@export var damage = -5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func im_hurt(damage):
	health -= damage
	if health <= 0:
		death()


func death():
	queue_free()
	is_dead = true
	dying_event.emit(is_dead)
	

func _on_body_entered(body):
	if body is PapaT:
		body.take_damage_or_heal(damage)
