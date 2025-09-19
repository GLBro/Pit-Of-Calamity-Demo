extends Area2D


export (bool) var active

func _ready() -> void:
	if active:
		$AnimatedSprite.play("right")
	else:
		$AnimatedSprite.play("left")



func _on_Lever_area_entered(area: Area2D) -> void:
		active = !active
		if active:
			$AnimatedSprite.play("right")
		else:
			$AnimatedSprite.play("left")

func is_active():
	return active
