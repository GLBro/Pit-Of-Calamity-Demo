extends Enemy

export (PackedScene) var Bomb_Scene

var ENEMY_SPEED = Vector2(100.0,300.0)
var enemy_velocity = Vector2.ZERO
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10
var dir = -1
var dir_timer = 0.0002
var current_knockback = Vector2.ZERO
var knockback_timer = 0.0
var dropable = true
signal drop_bomb(bullet, position, direction, speed, damage)

func _ready() -> void:
	defineEnemy(100,5,"Bomber")
	$AnimatedSprite.play("flying")
	get_parent().get_parent().get_parent().bomb_dropped()

func _physics_process(delta: float) -> void:
	enemy_velocity.y = move_toward(enemy_velocity.y,0,ENEMY_SPEED.y*100)
	enemy_velocity.x = move_toward(enemy_velocity.x,0,ENEMY_SPEED.x*100)
	if dir and dropable:
		enemy_velocity.x = dir*ENEMY_SPEED.x
	else:
		enemy_velocity.x = move_toward(enemy_velocity.x,0,ENEMY_SPEED.x/10)
	#if knockback_timer > 0.0:
	#	velocity.x += current_knockback.x
	#	velocity.y += current_knockback.y
	#	knockback_timer -= delta
	#	if (knockback_timer <= 0.0):
	#		current_knockback = Vector2.ZERO
	if (is_on_wall() and dir_timer < 0):
		dir *= -1
		dir_timer = 1.0
	dir_timer -= delta
	if knockback_timer > 0.0:
		enemy_velocity.x += current_knockback.x
		enemy_velocity.y += current_knockback.y
		knockback_timer -= delta
		if (knockback_timer <= 0.0):
			current_knockback = Vector2.ZERO
	move_and_slide(enemy_velocity,Vector2.UP)
	if get_node("../../../Player").global_position.x >= global_position.x-5 and get_node("../../../Player").global_position.x <= global_position.x+5 and dropable:
		dropable = false
		$DropTimer.start()
		drop_bomb()


func _process(delta: float) -> void:
	if (health <= 0):
		spawn_item()
		queue_free()

func apply_knockback(dir: Vector2, force: float, duration: float) -> void:
	current_knockback = dir*force
	knockback_timer = duration


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if (area is Bullet and not (area is Bomb)) or (area is Throwable) or (area is Sword):
		health -= area.get_damage()
		var knoc_dir = global_position.direction_to(area.global_position)
		apply_knockback(knoc_dir*-1,500,0.25)
		$Damage_Flicker.flicker()


func _on_DirTimer_timeout() -> void:
	dir *= -1


func drop_bomb():
	$AnimatedSprite.play("dropping")
	var bomb_instance = Bomb_Scene.instance()
	emit_signal("drop_bomb",bomb_instance,global_position,Vector2.DOWN,5,0)
	
	


func _on_DropTimer_timeout() -> void:
	dropable = true
	$AnimatedSprite.play("flying")
