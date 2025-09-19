extends Control

var SPRITES = {"Pistol":"res://assets/tempgun.png","Sword":"res://assets/tempsword.png","Sniper":"res://assets/sniper.png","Shotgun":"res://assets/shotgun.png","Rifle":"res://assets/rifle.png","Minigun":"res://assets/minigun.png","Shield":"res://assets/shield.png"}
var contains = null
onready var ammo_text = $Label

func setContents(type,ammo) -> void:
	contains = [type,ammo]
	var sprite = Sprite.new()
	sprite.texture = load(SPRITES[type])
	sprite.name = "Sprite"
	add_child(sprite)
	ammo_text.text = str(ammo)

func emptyContents():
	remove_child(get_node("Sprite"))
	contains = null
	ammo_text.text = ""

func enlarge():
	$AnimatedSprite.scale = Vector2(2,2)
	$Label.rect_scale = Vector2(2,2)
	$Label.rect_position.x = -40
	$Label.rect_position.y = 25
	if (get_node("Sprite") != null):
		$Sprite.scale = Vector2(1,1)

func delarge():
	$AnimatedSprite.scale = Vector2(1,1)
	$Label.rect_scale = Vector2(1,1)
	$Label.rect_position.x = -19
	$Label.rect_position.y = 13
	if (get_node("Sprite") != null):
		$Sprite.scale = Vector2(0.5,0.5)
