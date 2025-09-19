extends Gun


func _ready() -> void:
	defineGun(50,15,$Position2D,50,5,0.1,true)

func setGun(ammo):
	defineGun(50,15,$Position2D,ammo,5,0.1,true)
	print(ammo)

func maxAmmo():
	return 50
