extends Area2D
class_name Bullet

export (int) var speed = 10

var dir = Vector2.ZERO
var power = 1

func _physics_process(delta: float) -> void:
	if (dir != Vector2.ZERO):
		var velocity = dir*speed
		global_position += velocity
	
func set_direction(direction: Vector2):
	dir = direction
	look_at(get_global_mouse_position())

func set_speed(s: float):
	speed = s

func set_power(p: float):
	power = p

func get_damage() -> int:
	return power



func _on_Bullet_area_entered(area: Area2D) -> void:
	queue_free()


func _on_Bullet_body_entered(body: Node) -> void:
	queue_free()
