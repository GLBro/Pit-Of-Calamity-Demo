extends Area2D
class_name Coin

func _ready() -> void:
	$AnimationPlayer.play("idle")

func _on_Coin_area_entered(area: Area2D) -> void:
	get_node("../../../Player").add_gold(1)
	queue_free()
