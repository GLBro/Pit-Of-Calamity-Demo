extends Area2D

var ITEMS = ["res://src/items/Ammo.tscn","res://src/items/Big_Coin.tscn","res://src/items/Diamond.tscn","res://src/items/GoldenHeart.tscn","res://src/items/Heart.tscn","res://src/items/RandomItem.tscn","res://src/items/RandomItem.tscn","res://src/items/RandomItem.tscn","res://src/items/RandomItem.tscn"]
var generator = RandomNumberGenerator.new()
var opened = false

func _ready() -> void:
	$AnimatedSprite.play("closed")

func _on_Chest_area_entered(area: Area2D) -> void:
	if not opened:
		opened = true
		summon()
		$AnimatedSprite.play("open")
		$AnimationPlayer.play("fade")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	remove_child(get_node("AnimatedSprite"))
	remove_child(get_node("AnimationPlayer"))
	remove_child(get_node("CollisionShape2D"))
	queue_free()


func summon():
	generator.randomize()
	var random_num = generator.randi_range(0,ITEMS.size()-1)
	var item = ITEMS[random_num]
	var resource = load(item)
	var instance = resource.instance()
	instance.global_position = global_position
	instance.global_position.y -= 50
	get_parent().add_child(instance)
	
