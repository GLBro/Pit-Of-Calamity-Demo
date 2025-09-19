extends Node2D


func _process(delta: float) -> void:
	$VanishingWall.switch($Lever.is_active())
	$VanishingWall2.switch($Lever2.is_active())
