extends Node2D

export (PackedScene) var Item

func _ready() -> void:
	$Player/ArmR/Hand/Pistol.connect("fired",$Manager,"handle_fired")
	$Player.connect("reconnect",$".", "reconnectWeapon")
	$Player.connect("throw",$Manager,"handle_thrown")
	$Manager.connect("handle_fired",$GUI,"update_inventory")
	
	
func cannon_fired():
	for child in $LevelController.get_child(0).get_children():
		if child is Enemy:
			child.connect("fire_cannon",$Manager,"handle_fired")

func bomb_dropped():
	for child in $LevelController.get_child(0).get_children():
		if child is Enemy or child is Portal_Scene:
			child.connect("drop_bomb",$Manager,"handle_fired")

func explosion_iminant():
	for child in $Manager.get_children():
		if child is Bomb:
			child.connect("explode",$Manager,"handle_fired")

func infected_fired():
	for child in $LevelController.get_child(0).get_children():
		child.connect("fire_infected",$Manager,"handle_fired")

func spawnItem(item):
	for child in $LevelController.get_child(0).get_children():
		child.connect("equip_item",$Player,"add_to_inventory")

func reconnectWeapon(weapon) -> void:
	if weapon == "Pistol":
		reconnectPistol()
	elif weapon == "Sniper":
		reconnectSniper()
	elif weapon == "Shotgun":
		reconnectShotgun()
	elif weapon == "Rifle":
		reconnectRifle()
	elif weapon == "Minigun":
		reconnectMinigun()

func reconnectPistol():
	$Player/ArmR/Hand/Pistol.connect("fired",$Manager,"handle_fired")

func reconnectSniper():
	$Player/ArmR/Hand/Sniper.connect("fired",$Manager,"handle_fired")

func reconnectShotgun():
	$Player/ArmR/Hand/Shotgun.connect("fired",$Manager,"handle_fired")

func reconnectRifle():
	$Player/ArmR/Hand/Rifle.connect("fired",$Manager,"handle_fired")

func reconnectMinigun():
	$Player/ArmR/Hand/Minigun.connect("fired",$Manager,"handle_fired")
