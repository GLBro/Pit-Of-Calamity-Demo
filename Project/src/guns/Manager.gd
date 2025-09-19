extends Node2D

func handle_fired(bullet, position, direction, speed,power):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
	bullet.set_speed(speed)
	bullet.set_power(power)
	print("handled")

func handle_thrown(instance, item, ammo, position, direction, speed, power):
	add_child(instance)
	instance.global_position = position
	instance.set_direction(direction)
	instance.set_speed(speed)
	instance.set_power(power)
	instance.thrown(item,ammo)

