extends KinematicBody2D
class_name Enemy


var health = 1
var strength = 1
var type = "Enemy"
var ITEMS = ["res://src/items/Ammo.tscn","res://src/items/Big_Coin.tscn","res://src/items/Heart.tscn","res://src/Interactions/Chest.tscn","res://src/items/Coin.tscn","res://src/items/Coin.tscn","","",""]
var loaded_item = null
var generator = RandomNumberGenerator.new()


func _ready() -> void:
	generator.randomize()
	var load_thread = Thread.new()
	load_thread.start(self,"load_item")


func defineEnemy(h,s,t):
	health = h
	strength = s
	type = t

func get_damage():
	return strength

func load_item():
	var item = generator.randi_range(0,ITEMS.size()-1)
	if ITEMS[item] != "":
		loaded_item = load(ITEMS[item])

func spawn_item():
	if loaded_item != null:
		var instance = loaded_item.instance()
		instance.global_position = self.global_position
		get_parent().add_child(instance)
