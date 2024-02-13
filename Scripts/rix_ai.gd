extends Node2D

@onready var boss = $Path2D/PathFollow2D/Rixa
@onready var jotunn_ase = $Jotunn_ase
signal dying(is_dead, points)

@export var points := 500


func _ready():
	boss.jotunn_shot.connect(_on_boss_jotunn_shot)
	boss.dying_event.connect(_on_boss_death)

func _on_boss_jotunn_shot(jotunn_scene, location):
	var jshot = jotunn_scene.instantiate()
	jshot.global_position = location
	jotunn_ase.add_child(jshot)
	
func _on_boss_death(is_boss_dead):
	dying.emit(is_boss_dead, points)
