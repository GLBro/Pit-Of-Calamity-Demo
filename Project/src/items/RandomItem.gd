extends Node2D

onready var WEAPONS = ["Pistol","Rifle","Shotgun","Minigun","Sword","Shield","Sniper"]
onready var AMMO = {"Pistol":16,"Rifle":50,"Shotgun":12,"Minigun":150,"Sniper":5,"Sword":0,"Shield":0}
export (PackedScene) var Item
var generator = RandomNumberGenerator.new()

func _ready() -> void:
	var instance = Item.instance()
	generator.randomize()
	var random_num = generator.randi_range(0,WEAPONS.size()-1)
	var weapon = WEAPONS[random_num]
	var ammo = AMMO[weapon]
	instance.setContents(weapon,ammo)
	instance.global_position = global_position
	get_parent().add_child(instance)
	queue_free()
