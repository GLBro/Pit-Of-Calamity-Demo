extends Node2D


func set_direction(direction):
	$Infected_Bullet.set_direction(Vector2(0,-1))
	$Infected_Bullet2.set_direction(Vector2(-1,-1))
	$Infected_Bullet3.set_direction(Vector2(-1,0))
	$Infected_Bullet4.set_direction(Vector2(-1,1))
	$Infected_Bullet5.set_direction(Vector2(0,1))
	$Infected_Bullet6.set_direction(Vector2(1,1))
	$Infected_Bullet7.set_direction(Vector2(1,0))
	$Infected_Bullet8.set_direction(Vector2(1,-1))
	
func set_power(power):
	for child in get_children():
		child.set_power(power)

func set_speed(speed):
	for child in get_children():
		child.set_speed(speed)

func get_damage():
	return $Infected_Bullet.get_damage()
