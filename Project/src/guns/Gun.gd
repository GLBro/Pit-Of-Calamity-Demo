extends Node2D
class_name Gun

signal fired(bullet, position, direction, speed, damage)
export (PackedScene) var Bullet
onready var end_of_gun = null

var max_magazine = 0
var bullet_speed = 0
var current_mag = 0
var damage = 0
var max_cooldown = 0
var cooldown = 0
var auto = false

func _physics_process(delta: float) -> void:
	if cooldown > 0:
		cooldown -= delta

func defineGun(mm, bs, eog, cm, d, c, a) -> void:
	max_magazine = mm
	bullet_speed = bs
	end_of_gun = eog
	current_mag = cm
	damage = d
	max_cooldown = c
	auto = a


func _process(delta: float) -> void:
	if auto:
		if Input.is_action_pressed("attack") and current_mag > 0 and cooldown <= 0:
			fire()
			current_mag -= 1
	else:
		if Input.is_action_just_pressed("attack") and current_mag > 0 and cooldown <= 0:
			fire()
			current_mag -= 1



func fire() -> void:
	var bullet_instance = Bullet.instance()
	var bullet_dir = end_of_gun.global_position.direction_to(get_global_mouse_position()).normalized()
	emit_signal("fired", bullet_instance, end_of_gun.global_position, bullet_dir, bullet_speed, damage)
	cooldown = max_cooldown
	
