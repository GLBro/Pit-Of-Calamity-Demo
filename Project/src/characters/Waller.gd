extends Enemy

var ENEMY_SPEED = Vector2(100.0,300.0)
var jump_power = -750
var enemy_velocity = Vector2.ZERO
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10
var dir = -1
var current_knockback = Vector2.ZERO
var knockback_timer = 0.0
var jump_available = true

func _ready() -> void:
	defineEnemy(1000,1,"Waller")
	$AnimatedSprite.play("standing")

func _physics_process(delta: float) -> void:
	enemy_velocity.y += gravity*delta
	move_and_slide(enemy_velocity,Vector2.UP)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and jump_available:
		enemy_velocity.y = jump_power
		$AnimatedSprite.play("jumping")
		jump_available = false
		$Timer.start()

func _process(delta: float) -> void:
	if (health <= 0):
		queue_free()

func apply_knockback(dir: Vector2, force: float, duration: float) -> void:
	current_knockback = dir*force
	knockback_timer = duration


func _on_Hitbox_area_entered(area: Area2D) -> void:
	if (area is Bullet and not (area is Cannonball)) or (area is Throwable) or (area is Sword):
		health -= area.get_damage()
		var knoc_dir = global_position.direction_to(area.global_position)
		#apply_knockback(knoc_dir*-1,500,0.25)


func _on_Timer_timeout() -> void:
	jump_available = true
	$AnimatedSprite.play("standing")
