extends Gun


func _ready() -> void:
	defineGun(16,10,$Position2D,16,10,0,false)

func setGun(ammo):
	defineGun(16,10,$Position2D,ammo,10,0,false)
	print(ammo)

func maxAmmo():
	return 16
