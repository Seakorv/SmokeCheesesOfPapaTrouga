extends Sprite2D

@export var deathParticle : PackedScene

func _ready():
	await(get_tree().create_timer(1).timeout)
	kill()
	

func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = global_position
	_particle.rotation = global_rotation
	_particle.emitting = true
	add_child(_particle)
	
	queue_free()
