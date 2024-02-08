extends Area2D

@onready var sprite = $Sprite2D
##Adjust explosion size. The number is nothing specific, test which feels the best
@export var explosion_max_size = 40
var explosion_size = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if explosion_size <= explosion_max_size:
		scale += Vector2(200, 200) * delta
	explosion_size += 1
	if explosion_size == explosion_max_size:
		queue_free()


func _on_area_entered(area):
	if area is Food:
		area.die()
