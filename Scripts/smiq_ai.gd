extends Node2D

@onready var boss = $Path2D/PathFollow2D/Smiq
@onready var vex = $VexAse
signal dying(is_dead)

# Called when the node enters the scene tree for the first time.
func _ready():
	boss.vex_shot.connect(_on_boss_vex_shot)
	boss.dying_event.connect(_on_boss_death)


func _on_boss_vex_shot(vex_scene, location):
	var vexbullet = vex_scene.instantiate()
	vexbullet.global_position = location
	vex.add_child(vexbullet)
	

func _on_boss_death(is_boss_dead):
	dying.emit(is_boss_dead)
