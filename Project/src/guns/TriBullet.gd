extends Node2D


	
func set_direction(direction: Vector2):
	$Bullet.set_direction(direction+Vector2(0,0.1))
	$Bullet2.set_direction(direction)
	$Bullet3.set_direction(direction+Vector2(0,-0.1))

func set_speed(s: float):
	$Bullet.set_speed(s)
	$Bullet2.set_speed(s)
	$Bullet3.set_speed(s)

func set_power(p: float):
	$Bullet.set_power(p)
	$Bullet2.set_power(p)
	$Bullet3.set_power(p)

func get_damage() -> int:
	return $Bullet.get_power()
