extends KinematicBody2D
class_name Item

export (String) var start_type
export (int) var start_ammo
var velocity = Vector2.ZERO
var gravity = ProjectSettings.get("physics/2d/default_gravity")
var SPRITES = {"Pistol":"res://assets/tempgun.png","Sword":"res://assets/tempsword.png","Sniper":"res://assets/sniper.png","Shotgun":"res://assets/shotgun.png","Rifle":"res://assets/rifle.png","Minigun":"res://assets/rifle.png","Shield":"res://assets/shield.png"}
var contains = null
signal equip_item(item)

func _ready() -> void:
	if start_type != "":
		setContents(start_type,start_ammo)

func setContents(type,ammo) -> void:
	contains = [type,ammo]
	var sprite = Sprite.new()
	sprite.texture = load(SPRITES[type])
	add_child(sprite)



func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	move_and_slide(velocity)


func collected():
		var parent = self
		while parent.name != "Main":
			parent = parent.get_parent()
			print("parent")
		parent.spawnItem(contains)
		emit_signal("equip_item",contains)
		print("collected")
		queue_free()

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		visible = false
		var c_thread = Thread.new()
		c_thread.start(self,"collected")
