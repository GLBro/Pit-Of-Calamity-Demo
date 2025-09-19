extends Area2D
class_name BigCoin

func _ready() -> void:
	$AnimationPlayer.play("idle")



func _on_Big_Coin_area_entered(area: Area2D) -> void:
	get_node("../../../Player").add_gold(10)
	queue_free()
