extends Bullet



func _on_Timer_timeout() -> void:
	queue_free()


func _on_Explosion_body_entered(body) -> void:
	if body is Player:
		get_node("../../Player").damage_player(25,global_position)
