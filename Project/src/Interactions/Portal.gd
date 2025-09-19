extends Area2D
class_name Portal_Scene

export (PackedScene) var Bomb_Scene
signal drop_bomb(bullet, position, direction, speed, damage)

func _ready() -> void:
	get_parent().get_parent().get_parent().bomb_dropped()

func drop_bomb():
	randomize()
	global_position = Vector2((randi()%2250)+250,(randi()%500)+1000)
	$AnimationPlayer.play("appear")
	var bomb_instance = Bomb_Scene.instance()
	emit_signal("drop_bomb",bomb_instance,global_position,Vector2.DOWN,5,0)
