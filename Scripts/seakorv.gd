class_name Seakorv extends Boss

var olive_scene = preload("res://Scenes/olives.tscn")
var burgund_scene = preload("res://Scenes/burgund_stew.tscn")

signal olives_shot(olive_scene, location)
signal burgund_shot(burgund_scene, location)
signal olives_has_been_shot(start_teleports)

@export var health = 200
@export var new_texture = preload("res://Assets/Characters/Korv.png")
##How many olives will be shot in one burst. Break between burst is always 50 times the timer's wait time
@export var how_many_olives = 25
## How many olive burst will korvi shoot
@export var olive_bursts = 5
## speed for p2 jt-like attack
@export var speed = 5000
## how much damage does the p2 jt-style attack do
@export var damage = -5

@onready var olive_timer = $OliveTimer
@onready var burgund_timer = $BurgundShootTimer
@onready var bottomMuzzle = $Muzzzle1
@onready var topMuzzle = $Muzzzle2
@onready var burgund_muzzle = $BurgundMuzzle
@onready var korvi_sprite = $Sprite2D

#variable to send signal that enough olives has been shot
var start_teleports = false
# variable to define olive shooting bursts, like boss "smiq" shoots. Always keep these variables which are set at zero at zero. It is just a counter.
var olive_shoot_pacing = 0
# variable to count how many olive burst have been shot. Counter rises just before new burst.
var olive_burst_counter = 0
# How many burgund stews will be shot during one burst
var burgund_shoot_pacing = 0
# How many burst burgund stew gun will shoot
var burgund_burst_counter = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	korvi_sprite.texture = new_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func im_hurt(damage):
	health -= damage
	if health <= 0:
		death()
		

func death():
	queue_free()
	is_dead = true
	dying_event.emit(is_dead)
	
	
func _start_burgunds():
	pass
	

func _on_olive_timer_timeout():
	if olive_burst_counter == olive_bursts:
		olive_timer.stop()
		olive_burst_counter = 0
		start_teleports = true
		olives_has_been_shot.emit(start_teleports)
		start_teleports = false
	olive_shoot_pacing += 1
	if olive_shoot_pacing <= how_many_olives:
		olives_shot.emit(olive_scene, bottomMuzzle.global_position)
	if olive_shoot_pacing == how_many_olives+1:
		olive_burst_counter += 1
	if olive_shoot_pacing >= 50:
		olive_shoot_pacing = 0



func _on_burgund_shoot_timer_timeout():
	burgund_shoot_pacing += 1
	if burgund_shoot_pacing <= 10:
		burgund_shot.emit(burgund_scene, burgund_muzzle.global_position)
	if burgund_shoot_pacing > 10:
		burgund_shoot_pacing = 0
		burgund_timer.stop()
		

func _on_body_entered(body):
	if body is PapaT:
		body.take_damage_or_heal(damage)
