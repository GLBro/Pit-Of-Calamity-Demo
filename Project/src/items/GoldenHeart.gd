extends Area2D
class_name GoldenHeart


func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_GoldenHeart_area_entered(area: Area2D) -> void:
	get_node("../../../Player").upgrade_health(20)
	queue_free()
