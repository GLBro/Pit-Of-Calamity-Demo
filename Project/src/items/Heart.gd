extends Area2D
class_name Heart


func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_Heart_area_entered(area: Area2D) -> void:
	get_node("../../../Player").heal(100)
	queue_free()
