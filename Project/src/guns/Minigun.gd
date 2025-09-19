extends Gun


func _ready() -> void:
	defineGun(150,20,$Position2D,150,2,0.01,true)

func setGun(ammo):
	defineGun(150,20,$Position2D,ammo,2,0.01,true)
	print(ammo)

func maxAmmo():
	return 150
