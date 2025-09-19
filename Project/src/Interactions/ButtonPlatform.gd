extends KinematicBody2D


export (int) var x_vel
export (int) var y_vel

func _physics_process(delta: float) -> void:
	if $Button.is_pressed():
		move_and_slide(Vector2(x_vel,y_vel),Vector2.UP,false,4,0.78,true)
