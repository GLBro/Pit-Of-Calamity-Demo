extends Control

var main_scene = null


func _ready() -> void:
	var load_thread = Thread.new()
	load_thread.start(self,"load_main")
	$EnterButton.connect("pressed",$".","enter_pressed")
	$QuitButton.connect("pressed",$".","quit_pressed")
	$AnimatedSprite2.visible = false
	$AnimatedSprite.play("default")
	$ColorRect.color = "00000000"

func enter_pressed(text):
	$AnimationPlayer.play("fade_buttons")
	$AnimationPlayer2.play("move_player")
	$AnimationPlayer3.play("eye")
	$AnimationPlayer4.play("fade_back")

func _process(delta: float) -> void:
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()


func _on_AnimationPlayer4_animation_finished(anim_name: String) -> void:
	while main_scene == null:
		var wait = 0
	get_tree().change_scene_to(main_scene)

func quit_pressed(text):
	get_tree().quit()

func load_main():
	main_scene = load("res://src/Main.tscn")
	print("loaded")
