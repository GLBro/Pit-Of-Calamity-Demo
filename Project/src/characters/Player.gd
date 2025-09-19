extends KinematicBody2D
class_name Player

#CONSTANTS
var SPEED = Vector2(300.0,300.0)
var JUMP_VELOCITY = -550.0
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10
var MAX_VELOCITY = Vector2(350.0,500.0)
var MIN_VELOCTIY = Vector2(-350.0,-700.0)
onready var LEFT_ARM = get_node("ArmL")
onready var weapon_node = get_node("ArmR/Hand/Pistol")
var KNOCKBACK = {"Pistol":10,"Sword":0,"Sniper":40,"Shotgun":100,"Rifle":10,"Minigun":20}
var item_launch = -3


var velocity = Vector2.ZERO
var inventory = [["Pistol",16],["Nothing",0],["Nothing",0]]
var selected = 0
var current_knockback = Vector2.ZERO
var knockback_timer = 0.0
var health = 100
var max_health = 100
var current_health = 100
var shielding = false
var reloads = 0
var gold = 0
var damaged = false
var infected = false
var shootable = true

export (PackedScene) onready var Throwable
export (PackedScene) onready var Pistol
export (PackedScene) onready var Sword
export (PackedScene) onready var Sniper
export (PackedScene) onready var Shotgun
export (PackedScene) onready var Rifle
export (PackedScene) onready var Minigun
export (PackedScene) onready var Shield
signal reconnect(weapon)
signal throw(instance,item,ammo,pos,direction,speed,power)


func _ready() -> void:
	get_node("../GUI").get_inventory(inventory)
	get_node("../GUI").update_inventory(selected)

func _physics_process(delta: float) -> void:
	if velocity.y < MIN_VELOCTIY.y:
		velocity.y = MIN_VELOCTIY.y
	if is_on_ceiling():
		velocity.y = 0
	if (not is_on_floor()) and (velocity.y < MAX_VELOCITY.y):
		velocity.y += gravity*delta
		velocity.x = move_toward(velocity.x,0,SPEED.x/50)
	if Input.is_action_just_pressed("jump") and is_on_floor() and health > 0:
		velocity.y = JUMP_VELOCITY
		if get_node("../LevelController").get_child(0).name == "Level7":
			velocity.y = JUMP_VELOCITY-100
		if not damaged:
			$AnimatedSprite.play("stationary")
	var dir = Input.get_axis("move_left","move_right")
	if health <= 0:
		dir = 0.0
	if is_on_wall() and (velocity.x > 10 or velocity.x < -10):
		velocity.x = 0
	if dir and not shielding:
		if velocity.x == 0:
			velocity.x += (dir*SPEED.x)/5
		else:
			velocity.x += (dir*SPEED.x)/25
		if (velocity.x > MAX_VELOCITY.x):
			velocity.x = MAX_VELOCITY.x
		elif (velocity.x < 0-MAX_VELOCITY.x):
			velocity.x = 0-MAX_VELOCITY.x
		if is_on_floor() and velocity.y >= 0 and not damaged:
			$AnimatedSprite.play("moving")
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x,0,SPEED.x/5)
		$AnimatedSprite.play("stationary")
	if knockback_timer > 0.0:
		velocity.x += current_knockback.x
		velocity.y += current_knockback.y
		knockback_timer -= delta
		if (knockback_timer <= 0.0):
			current_knockback = Vector2.ZERO
	move_and_slide(velocity,Vector2.UP)
	firing()
	

func _process(delta: float) -> void:
	$ArmL.look_at($ArmR/Hand.global_position)
	$ArmR.look_at(get_global_mouse_position())
	if get_global_mouse_position().x < global_position.x:
		for child in $ArmR/Hand.get_children():
			child.scale.y = -1
	else:
		for child in $ArmR/Hand.get_children():
			child.scale.y = 1

func firing():
	if health > 0:
		if $ArmR/Hand.get_children().size() > 0:
			if $ArmR/Hand.get_children()[0].auto:
				if Input.is_action_pressed("attack") and inventory[selected][0] == "Shield":
					shielding = true
				else:
					shielding = false
				if Input.is_action_pressed("attack") and inventory[selected][1] != 0 and shootable:
					shootable = false
					inventory[selected][1] -= 1
					var dir = (global_position - get_global_mouse_position()).normalized()
					apply_knockback(dir,KNOCKBACK[inventory[selected][0]],0.1)
					$AudioStreamPlayer.play()
					get_node("../GUI").get_inventory(inventory)
					get_node("../GUI").update_inventory(selected)
					$Cooldown_Timer.start()
			else:
				if Input.is_action_just_pressed("attack") and inventory[selected][0] == "Shield":
					shielding = true
				else:
					shielding = false
				if Input.is_action_just_pressed("attack") and inventory[selected][1] != 0 and shootable:
					shootable = false
					inventory[selected][1] -= 1
					var dir = (global_position - get_global_mouse_position()).normalized()
					apply_knockback(dir,KNOCKBACK[inventory[selected][0]],0.1)
					$AudioStreamPlayer.play()
					get_node("../GUI").get_inventory(inventory)
					get_node("../GUI").update_inventory(selected)
					$Cooldown_Timer.start()
		if Input.is_action_pressed("throw") and inventory[selected][0] != "Nothing":
			var throw_instance = Throwable.instance()
			var throw_dir = global_position.direction_to(get_global_mouse_position()).normalized()
			emit_signal("throw",throw_instance, inventory[selected][0],inventory[selected][1], global_position, throw_dir, 20, 10)
			inventory[selected][0] = "Nothing"
			inventory[selected][1] = 0
			$AudioStreamPlayer2D.play()
			update_selected()
	if Input.is_action_just_pressed("inv_left"):
		if (selected == 0):
			selected = inventory.size()-1
		else:
			selected -= 1
		update_selected()
	if Input.is_action_just_pressed("inv_right"):
		if (selected == inventory.size()-1):
			selected = 0
		else:
			selected += 1
		update_selected()
	elif Input.is_action_pressed("reload") and reloads > 0:
		reloads -= 1
		reload()

func update_selected():
	if weapon_node != null:
		$ArmR/Hand.remove_child(weapon_node)
	if (inventory[selected][0] == "Pistol"):
		var next = Pistol.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(inventory[selected][1])
		weapon_node = $ArmR/Hand/Pistol
		emit_signal("reconnect","Pistol")
	elif (inventory[selected][0] == "Sword"):
		$ArmR/Hand.add_child(Sword.instance())
		weapon_node = $ArmR/Hand/Sword
	elif (inventory[selected][0] == "Shield"):
		$ArmR/Hand.add_child(Shield.instance())
		weapon_node = $ArmR/Hand/Shield
	elif (inventory[selected][0] == "Sniper"):
		var next = Sniper.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(inventory[selected][1])
		weapon_node = $ArmR/Hand/Sniper
		emit_signal("reconnect","Sniper")
	elif (inventory[selected][0] == "Shotgun"):
		var next = Shotgun.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(inventory[selected][1])
		weapon_node = $ArmR/Hand/Shotgun
		emit_signal("reconnect","Shotgun")
	elif (inventory[selected][0] == "Rifle"):
		var next = Rifle.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(inventory[selected][1])
		weapon_node = $ArmR/Hand/Rifle
		emit_signal("reconnect","Rifle")
	elif (inventory[selected][0] == "Minigun"):
		var next = Minigun.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(inventory[selected][1])
		weapon_node = $ArmR/Hand/Minigun
		emit_signal("reconnect","Minigun")
	elif (inventory[selected][0] == "Nothing"):
		weapon_node = null
	if weapon_node != null:
		$Cooldown_Timer.wait_time = weapon_node.max_cooldown
	get_node("../GUI").get_inventory(inventory)
	get_node("../GUI").update_inventory(selected)
		

func apply_knockback(dir: Vector2, force: float, duration: float) -> void:
	current_knockback = dir*force
	knockback_timer = duration



func _on_Hitbox_body_entered(body: Node) -> void:
	if not shielding:
		damage_player(body.get_damage(),body.global_position)
		get_node("../GUI").update_health(health)

func damage_player(damage, area_position):
	if not shielding and not damaged:
		var dir = global_position.direction_to(area_position)
		apply_knockback(dir*-1,100,0.1)
		health -= damage
		get_node("../GUI").update_health(health)
		$AudioStreamPlayer2D2.play()
		flicker()
		if health <= 0:
			get_node("../GUI").game_over()


func add_to_inventory(item):
	if (inventory[selected][0] == "Nothing"):
		inventory[selected] = item
		update_selected()
	else:
		var added = false
		for i in range (inventory.size()):
			if inventory[i][0] == "Nothing":
				inventory[i] = item
				added = true
				update_selected()
				break
		if not added:
			var throw_instance = Throwable.instance()
			var dir = Input.get_axis("move_left","move_right")
			emit_signal("throw",throw_instance,item[0],item[1],global_position,Vector2(dir*3,-3),5,1)
			item_launch -= 0.1
	get_node("../GUI").get_inventory(inventory)

func heal(amount):
	health += amount
	infected = false
	get_node("../GUI/background_health/current_health").modulate = Color.white
	if health > max_health:
		health = max_health
		get_node("../GUI").update_health(health)

func upgrade_health(amount):
	max_health += amount
	health = max_health
	infected = false
	get_node("../GUI/background_health/current_health").modulate = Color.white
	get_node("../GUI").update_max_health(health)

func reload():
	if weapon_node != null:
		$ArmR/Hand.remove_child(weapon_node)
	if (inventory[selected][0] == "Pistol"):
		var next = Pistol.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(next.maxAmmo())
		inventory[selected][1] = next.maxAmmo()
		weapon_node = $ArmR/Hand/Pistol
		emit_signal("reconnect","Pistol")
	elif (inventory[selected][0] == "Sword"):
		$ArmR/Hand.add_child(Sword.instance())
		weapon_node = $ArmR/Hand/Sword
	elif (inventory[selected][0] == "Shield"):
		$ArmR/Hand.add_child(Shield.instance())
		weapon_node = $ArmR/Hand/Shield
	elif (inventory[selected][0] == "Sniper"):
		var next = Sniper.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(next.maxAmmo())
		inventory[selected][1] = next.maxAmmo()
		weapon_node = $ArmR/Hand/Sniper
		emit_signal("reconnect","Sniper")
	elif (inventory[selected][0] == "Shotgun"):
		var next = Shotgun.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(next.maxAmmo())
		inventory[selected][1] = next.maxAmmo()
		weapon_node = $ArmR/Hand/Shotgun
		emit_signal("reconnect","Shotgun")
	elif (inventory[selected][0] == "Rifle"):
		var next = Rifle.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(next.maxAmmo())
		inventory[selected][1] = next.maxAmmo()
		weapon_node = $ArmR/Hand/Rifle
		emit_signal("reconnect","Rifle")
	elif (inventory[selected][0] == "Minigun"):
		var next = Minigun.instance()
		$ArmR/Hand.add_child(next)
		next.setGun(next.maxAmmo())
		inventory[selected][1] = next.maxAmmo()
		weapon_node = $ArmR/Hand/Minigun
		emit_signal("reconnect","Minigun")
	elif (inventory[selected][0] == "Nothing"):
		weapon_node = null
	get_node("../GUI").get_inventory(inventory)
	get_node("../GUI").update_inventory(selected)
	get_node("../GUI").remove_ammo()

func add_ammo():
	reloads += 1

func add_gold(amount):
	gold += amount
	get_node("../GUI").update_gold(gold)

func flicker():
	if not damaged:
		damaged = true
		$Flicker_Timer.start()
		$Red_Timer.start()

func _on_Red_Timer_timeout() -> void:
	if damaged:
		$AnimatedSprite.play("damaged")
		$Black_Timer.start()


func _on_Black_Timer_timeout() -> void:
	if damaged:
		$AnimatedSprite.play("stationary")
		$Red_Timer.start()



func _on_Flicker_Timer_timeout() -> void:
	damaged = false
	$AnimatedSprite.play("stationary")


func infect():
	infected = true
	$Infect_Timer.start()
	get_node("../GUI").infect()


func _on_Infect_Timer_timeout() -> void:
	if infected:
		damage_player(1,global_position)
		$Infect_Timer.start()


func _on_Cooldown_Timer_timeout() -> void:
	shootable = true
