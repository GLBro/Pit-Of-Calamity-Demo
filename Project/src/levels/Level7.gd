extends Node2D


func _process(delta: float) -> void:
	$VanishingWall.switch($Lever.is_active())
	$VanishingWall2.switch($Lever2.is_active())
	$VanishingWall3.switch($Lever3.is_active())
	$VanishingWall4.switch($Lever4.is_active())
	$VanishingWall5.switch($Lever5.is_active())
