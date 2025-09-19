extends Area2D




func _on_Spike_body_entered(body: Node) -> void:
	if body is Player:
		body.damage_player(10,global_position)
		body.apply_knockback(Vector2.UP,200,0.1)
