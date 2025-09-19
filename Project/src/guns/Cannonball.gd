extends Bullet
class_name Cannonball

func _ready() -> void:
	set_power(15)
	set_speed(5)
	set_direction(Vector2(1,0))

func set_left(left):
	if left:
		set_direction(Vector2(-1,0))
	else:
		set_direction(Vector2(1,0))



func _on_Cannonball_area_entered(area: Area2D) -> void:
	var wait = 0
	#queue_free()




func _on_Cannonball_body_entered(body: Node) -> void:
	if body is Player:
		get_parent().get_parent().get_node("Player").damage_player(15,global_position)
		queue_free()
	if not body is Enemy:
		queue_free()
