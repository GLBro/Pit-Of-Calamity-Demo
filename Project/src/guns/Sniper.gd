extends Gun


func _ready() -> void:
	defineGun(5,30,$Position2D,5,100,1,false)

func setGun(ammo):
	defineGun(5,30,$Position2D,ammo,100,1,false)
	print(ammo)

func maxAmmo():
	return 5
