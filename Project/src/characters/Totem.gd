extends KinematicBody2D

var enemy_velocity = Vector2.ZERO
var speed = 100.0
var dir = -1
var dir_timer = 0.002
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10
onready var wheel = load("res://src/Interactions/Wheel.tscn")
export (PackedScene) var Infected_Bullet
signal fire_infected(bullet, position, direction, speed, damage)

var stat = false
var local_health = 100
var cannon_health = 100
var bomber_health = 100
var charger_health = 100
var waller_health = 200
var infected_health = 200
var sections = 6
var local_check = false
var total_health = local_health+cannon_health+bomber_health+charger_health+waller_health+infected_health

func _ready() -> void:
	get_parent().get_parent().get_parent().infected_fired()
	$Legs/AnimatedSprite.play("walking")
	$JumpTimer.start()
	$StaticTimer.start()

func _process(delta: float) -> void:
	var current_health = local_health+cannon_health+bomber_health+charger_health+waller_health+infected_health
	get_node("../../../GUI").update_boss_health(current_health/total_health)
	if local_health <= 0 and cannon_health <= 0 and bomber_health <= 0 and charger_health <= 0 and waller_health <= 0 and infected_health <= 0:
		queue_free()
		get_node("../../../GUI").hide_boss_health()
		get_node("../../../GUI/Label2").visible = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		enemy_velocity.y += gravity*delta
	else:
		if enemy_velocity.y > 50 and is_on_floor() and not local_check:
			perform_attack()
		enemy_velocity.y = 0
		$Legs.visible = true
		local_check = false
	if dir:
		enemy_velocity.x = dir*speed
	else:
		enemy_velocity.x = move_toward(enemy_velocity.x,0,speed/10)
	if (is_on_wall() and dir_timer < 0):
		dir *= -1
		dir_timer = 1.0
	dir_timer -= delta
	move_and_slide(enemy_velocity,Vector2.UP)


func _on_JumpTimer_timeout() -> void:
	enemy_velocity.y = -1000
	$Legs.visible = false
	randomize()
	$JumpTimer.wait_time = (randi()%5)+5
	$JumpTimer.start()


func _on_StaticTimer_timeout() -> void:
	stat = true
	if local_health > 0:
		$LocalNode/AnimatedSprite.play("static")
	if cannon_health > 0:
		$CannonNode/AnimatedSprite.play("static")
		$CannonNode/AnimatedSprite2.visible = false
		$CannonNode/AnimatedSprite3.visible = false
	if bomber_health > 0:
		$BomberNode/AnimatedSprite.play("static")
		$BomberNode/AnimatedSprite2.visible = false
		$BomberNode/AnimatedSprite3.visible = false
	if charger_health > 0:
		$ChargerNode/AnimatedSprite.play("static")
		$ChargerNode/AnimatedSprite2.visible = false
		$ChargerNode/AnimatedSprite3.visible = false
	if waller_health > 0:
		$WallerNode/AnimatedSprite.play("static")
	if infected_health > 0:
		$InfectedNode/AnimatedSprite.play("static")
	var poss = {6:[0,64,128,192,256,320],5:[64,128,192,256,320],4:[128,192,256,320],3:[192,256,320],2:[256,320],1:[320]}
	var pos = poss[sections]
	randomize()
	pos.shuffle()
	var counter = 0
	if local_health > 0:
		$LocalNode.position.y = pos[counter]
		counter += 1
	if cannon_health > 0:
		$CannonNode.position.y = pos[counter]
		counter += 1
	if bomber_health > 0:
		$BomberNode.position.y = pos[counter]
		counter += 1
	if charger_health > 0:
		$ChargerNode.position.y = pos[counter]
		counter += 1
	if waller_health > 0:
		$WallerNode.position.y = pos[counter]
		counter += 1
	if infected_health > 0:
		$InfectedNode.position.y = pos[counter]
		counter += 1
	$StaticDelay.start()


func _on_StaticDelay_timeout() -> void:
	if local_health > 0:
		$LocalNode/AnimatedSprite.play("default")
	if cannon_health > 0:
		$CannonNode/AnimatedSprite.play("default")
		$CannonNode/AnimatedSprite2.visible = true
		$CannonNode/AnimatedSprite3.visible = true
	if bomber_health > 0:
		$BomberNode/AnimatedSprite.play("default")
		$BomberNode/AnimatedSprite2.visible = true
		$BomberNode/AnimatedSprite3.visible = true
	if charger_health > 0:
		$ChargerNode/AnimatedSprite.play("default")
		$ChargerNode/AnimatedSprite2.visible = true
		$ChargerNode/AnimatedSprite3.visible = true
	if waller_health > 0:
		$WallerNode/AnimatedSprite.play("default")
	if infected_health > 0:
		$InfectedNode/AnimatedSprite.play("default")
	stat = false
	$StaticTimer.start(10)


func _on_LocalNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		local_health -= area.get_damage()
		$LocalNode/Damage_Flicker.flicker()
		if local_health <= 0:
			remove_child($LocalNode)
			sections -= 1
			$StaticTimer.start(0.1)


func _on_CannonNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		cannon_health -= area.get_damage()
		$CannonNode/Damage_Flicker.flicker()
		if cannon_health <= 0:
			remove_child($CannonNode)
			sections -= 1
			$StaticTimer.start(0.1)


func _on_BomberNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		bomber_health -= area.get_damage()
		$BomberNode/Damage_Flicker.flicker()
		if bomber_health <= 0:
			remove_child($BomberNode)
			sections -= 1
			$StaticTimer.start(0.1)


func _on_ChargerNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		charger_health -= area.get_damage()
		$ChargerNode/Damage_Flicker.flicker()
		if charger_health <= 0:
			remove_child($ChargerNode)
			sections -= 1
			$StaticTimer.start(0.1)


func _on_WallerNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		waller_health -= area.get_damage()
		$WallerNode/Damage_Flicker.flicker()
		if waller_health <= 0:
			remove_child($WallerNode)
			sections -= 1
			$StaticTimer.start(0.1)


func _on_InfectedNode_area_entered(area: Area2D) -> void:
	if area is Bullet and not stat:
		infected_health -= area.get_damage()
		$InfectedNode/Damage_Flicker.flicker()
		if infected_health <= 0:
			remove_child($InfectedNode)
			sections -= 1
			$StaticTimer.start(0.1)


func perform_attack():
	var type = null
	for child in get_children():
		if child.position.y == 320:
			type = child.name
			break
	if type == "LocalNode":
		local_attack()
	elif type == "CannonNode":
		cannon_attack()
	elif type == "BomberNode":
		bomber_attack()
	elif type == "ChargerNode":
		charger_attack()
	elif type == "WallerNode":
		waller_attack()
	elif type == "InfectedNode":
		infected_attack()
		


func charger_attack():
	get_node("../SpikePlayer").play("raise_spikes")

func cannon_attack():
	get_node("../Wheel").global_position = Vector2(global_position.x+200,global_position.y-200)
	get_node("../Wheel2").global_position = Vector2(global_position.x-200,global_position.y-200)
	get_node("../WheelPlayer").play("show_wheels")

func waller_attack():
	get_node("../../../Player/AnimationPlayer").play("spin_camera")
	#get_node("../../../Player/Node2D").rotate(3.14/2)

func bomber_attack():
	for i in range(10):
		var string = "../Portal"+str(i+1)
		get_node(string).drop_bomb()

func infected_attack():
	var instance = Infected_Bullet.instance()
	emit_signal("fire_infected",instance,global_position,Vector2.ZERO,15,5)

func local_attack():
	local_check = true
	enemy_velocity.y = -1000
	$AnimationPlayer.play("spin")
