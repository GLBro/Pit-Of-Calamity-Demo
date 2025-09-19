extends Enemy

var ENEMY_SPEED = Vector2(100.0,300.0)
var jump_power = -500
var enemy_velocity = Vector2.ZERO
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10
var dir = -1
var current_knockback = Vector2.ZERO
var knockback_timer = 0.0
var jump_available = true
var moving = false

func _ready() -> void:
	defineEnemy(100,20,"Charger")
	$AnimatedSprite.play("walking")

func _physics_process(delta: float) -> void:
	if moving:
		if not is_on_floor():
			enemy_velocity.y += gravity*delta
		else:
			enemy_velocity.y = 0
		if is_on_wall() and jump_available:
			enemy_velocity.y = jump_power
			jump_available = false
			$Timer.start()
		if global_position.x > get_node("../../../Player").global_position.x:
			dir = -1
		else:
			dir = 1
		if dir:
			enemy_velocity.x = dir*ENEMY_SPEED.x
		else:
			enemy_velocity.x = move_toward(enemy_velocity.x,0,ENEMY_SPEED.x/10)
		if knockback_timer > 0.0:
			enemy_velocity.x += current_knockback.x
			enemy_velocity.y += current_knockback.y
			knockback_timer -= delta
			if (knockback_timer <= 0.0):
				current_knockback = Vector2.ZERO
			if (enemy_velocity.y < -700):
				enemy_velocity.y = -700
		move_and_slide(enemy_velocity,Vector2.UP)


func _process(delta: float) -> void:
	if (health <= 0):
		spawn_item()
		queue_free()

func apply_knockback(dir: Vector2, force: float, duration: float) -> void:
	current_knockback = dir*force
	knockback_timer = duration


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if (area is Bullet and not (area is Cannonball)) or (area is Throwable) or (area is Sword):
		health -= area.get_damage()
		var knoc_dir = global_position.direction_to(area.global_position)
		apply_knockback(knoc_dir*-1,500,0.25)
		$Damage_Flicker.flicker()


func _on_Timer_timeout() -> void:
	jump_available = true


func _on_Activation_body_entered(body: Node) -> void:
	if body is Player:
		moving = true
