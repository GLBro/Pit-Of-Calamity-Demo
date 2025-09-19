extends Gun


func _ready() -> void:
	defineGun(12,10,$Position2D,12,10,1,false)

func setGun(ammo):
	defineGun(12,10,$Position2D,ammo,10,1,false)
	print(ammo)

func maxAmmo():
	return 12
