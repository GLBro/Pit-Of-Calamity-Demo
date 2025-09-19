extends Bullet
class_name Bomb

export (PackedScene) var Explosion
signal explode(bullet, position, direction, speed, damage)

func _ready() -> void:
	get_parent().get_parent().explosion_iminant()
	set_direction(Vector2.DOWN)
	set_power(0)
	set_speed(5)
	look_at(Vector2.UP)



func _on_Bomb_body_entered(body: Node) -> void:
	if not body is Enemy:
		print("detected")
		var explosion_instance = Explosion.instance()
		emit_signal("explode",explosion_instance,global_position,Vector2.ZERO,0,25)
		queue_free()
