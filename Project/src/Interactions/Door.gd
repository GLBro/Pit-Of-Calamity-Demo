extends Area2D

export (bool) var locked


func _ready() -> void:
	if locked:
		$AnimatedSprite.play("closed")
	else:
		$AnimatedSprite.play("open")




func _on_Door_body_entered(body: Node) -> void:
	if body is Player and not locked:
		get_node("../../../Player/Node2D/Camera2D").smoothing_enabled = false
		$AnimationPlayer.play("Enlarge")
		get_node("../../../GUI/AnimationPlayer").play("whiten")
		$Delay.start()

func unlock():
	$AnimatedSprite.play("open")
	locked = false


func _on_Delay_timeout() -> void:
	get_parent().get_parent().next_level()
