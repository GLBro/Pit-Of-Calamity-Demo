extends Area2D


export (String) var text
var default_background = "250042"
var default_outline = "000000"
var hover_background = "9814ff"
var select_outline = "ffffffff"
var hovering = false
signal pressed(text)


func _ready() -> void:
	$Label.text = text
	$Background.color = default_background
	$Outline.color = default_outline

func _process(delta: float) -> void:
	if hovering and Input.is_action_just_pressed("attack"):
		$Outline.color = select_outline
		$Timer.start()
		emit_signal("pressed",text)
		print("pressed")


func _on_UIButton_mouse_entered() -> void:
	$Background.color = hover_background
	hovering = true




func _on_UIButton_mouse_exited() -> void:
	$Background.color = default_background
	hovering = false


func _on_Timer_timeout() -> void:
	$Outline.color = default_outline
