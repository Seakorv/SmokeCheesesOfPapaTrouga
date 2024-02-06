extends Node2D

signal dying(is_dead)

@onready var korvi = $Seakorv
@onready var bullet_container = $Olive_container
@onready var attack_timer = $TimerBasedMovement



# Called when the node enters the scene tree for the first time.
func _ready():
	korvi.olives_shot.connect(_on_olives_shot)
	korvi.dying_event.connect(_on_korvi_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_olives_shot(olive_scene, location):
	var olives = olive_scene.instantiate()
	olives.global_position = location
	bullet_container.add_child(olives)


func _on_korvi_death(is_boss_dead):
	dying.emit(is_boss_dead)


func _on_timer_based_movement_timeout():
	pass # Replace with function body.
