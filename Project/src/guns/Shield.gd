extends Area2D

var power = 5
var cooldown = -1
var auto = false

func set_damage(d):
	power = d

func get_damage() -> int:
	return power

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		$AnimatedSprite.play("shielding")
	else:
		$AnimatedSprite.play("collapsed")
