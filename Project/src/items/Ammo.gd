extends Area2D
class_name Ammo


func _ready() -> void:
	$AnimationPlayer.play("idle")


func _on_Ammo_area_entered(area: Area2D) -> void:
	get_node("../../../Player").add_ammo()
	get_node("../../../GUI").add_ammo()
	queue_free()
