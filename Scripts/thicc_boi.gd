class_name Thicc_Boi extends Veljekset_Li

var player_position
var target_position
@export var damage = -5

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		

func _physics_process(delta):
	player = get_tree().get_first_node_in_group("player")
	player_position = player.position
	target_position = (player_position - position).normalized()
	position += target_position * delta * speed
	

func _on_body_entered(body):
	if body is PapaT:
		body.take_damage_or_heal(damage)


func im_hurt(damage):
	health -= damage
	random_spawn()
	if health <= 0:
		death()


func death():
	queue_free()
	boss_explosion()
	is_dead = true
	dying_event.emit(is_dead)


func random_spawn():
	var y = randi_range(50, 1030)
	position = Vector2(1800, y)
