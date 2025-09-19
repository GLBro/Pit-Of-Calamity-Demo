extends Bullet
class_name Throwable

export (PackedScene) var Item
var SPRITES = {"Pistol":"res://assets/tempgun.png","Sword":"res://assets/tempsword.png","Sniper":"res://assets/sniper.png","Shotgun":"res://assets/shotgun.png","Rifle":"res://assets/rifle.png","Minigun":"res://assets/rifle.png","Shield":"res://assets/shield.png"}
var velocity = Vector2.ZERO
var item = null
var ammo = null

func thrown(i,a):
	$Sprite.texture = load(SPRITES[i])
	item = i
	ammo = a

func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta*0.5
	global_position.y += velocity.y
	global_rotation += 1


func _on_Throwable_body_entered(body: Node) -> void:
	var instance = Item.instance()
	instance.setContents(item,ammo)
	instance.global_position = global_position
	get_parent().get_parent().get_node("LevelController").get_child(0).add_child(instance)
	instance.global_position = global_position
	queue_free()
