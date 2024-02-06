extends Node2D

@onready var anim_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("korvStart")
	anim_player.animation_finished.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
