extends Area2D




func _on_Key_area_entered(area: Area2D) -> void:
	get_node("../Door").unlock()
	queue_free()
