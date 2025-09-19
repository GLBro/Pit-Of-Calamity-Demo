extends Area2D
class_name Diamond

func _ready() -> void:
	$AnimationPlayer.play("idle")
	$AnimatedSprite.play()




func _on_Diamond_area_entered(area: Area2D) -> void:
	get_node("../../../Player").add_gold(50)
	queue_free()
