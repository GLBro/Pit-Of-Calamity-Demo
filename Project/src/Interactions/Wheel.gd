extends KinematicBody2D


export (bool) var right
export (int) var speed
var move = false
var velocity = Vector2.ZERO
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")*10

func _physics_process(delta: float) -> void:
	if move:
		if not is_on_floor():
			velocity.y += gravity*delta
		else:
			velocity.y = 0
		if right:
			self.rotate(speed*0.00314)
			velocity.x = speed*10
		else:
			self.rotate(speed*-0.00314)
			velocity.x = -speed*10
		move_and_slide(velocity,Vector2.UP)
		if is_on_wall():
			right = !right


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player and move:
		body.damage_player(speed,global_position)




func _on_Actviation_body_entered(body: Node) -> void:
	if body is Player:
		move = true
