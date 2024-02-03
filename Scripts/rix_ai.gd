extends Node2D

@onready var boss = $Path2D/PathFollow2D/Rixa
@onready var jotunn_ase = $Jotunn_ase

func _ready():
	boss.jotunn_shot.connect(_on_boss_jotunn_shot)
	

func _on_boss_jotunn_shot(jotunn_scene, location):
	var jshot = jotunn_scene.instantiate()
	jshot.global_position = location
	jotunn_ase.add_child(jshot)
	

