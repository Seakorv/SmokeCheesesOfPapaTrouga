extends CharacterBody2D


const SPEED = 1000.0


func _physics_process(delta):

	# Restricting character movement into the screen

	# Movement with vector2
	var direction = Vector2(0, Input.get_axis("move_up", "move_down"))
	velocity = direction * SPEED
	move_and_slide()
	
