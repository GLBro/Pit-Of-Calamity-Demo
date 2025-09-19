extends Bullet

func _ready() -> void:
	set_power(5)
	set_speed(15)
	set_direction(Vector2(1,0))



func _on_Infected_Bullet_body_entered(body: Node) -> void:
	if body is Player:
		get_parent().get_parent().get_parent().get_node("Player").infect()
		queue_free()
	if not body is Enemy:
		queue_free()


func _on_Timer_timeout() -> void:
	queue_free()
