extends Area2D
class_name Sword

var power = 10
var cooldown = -1
var auto = false

func set_damage(d):
	power = d

func get_damage() -> int:
	return power

