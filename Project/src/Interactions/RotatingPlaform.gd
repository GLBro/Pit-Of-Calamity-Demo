extends KinematicBody2D


export (bool) var clockwise
export (int) var speed

func _physics_process(delta: float) -> void:
	if clockwise:
		self.rotate(speed*0.00314)
	else:
		self.rotate(0-(speed*0.00314))
