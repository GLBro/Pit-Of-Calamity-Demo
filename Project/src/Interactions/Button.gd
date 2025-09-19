extends Area2D

var pressed = false

func _ready() -> void:
	$AnimatedSprite.play("not_pressed")

func _on_Button_area_entered(area: Area2D) -> void:
	$AnimatedSprite.play("pressed")
	pressed = true



func _on_Button_area_exited(area: Area2D) -> void:
	$AnimatedSprite.play("not_pressed")
	pressed = false

func is_pressed():
	return pressed
