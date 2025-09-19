extends Node2D


func _process(delta: float) -> void:
	$VanishingWall.switch($Lever.is_active())
	$VanishingWall2.switch($Lever2.is_active())
	$VanishingWall3.switch($Lever3.is_active())
	$VanishingWall4.switch(!$Lever3.is_active())
	$VanishingWall5.switch($Lever4.is_active())
	$VanishingWall6.switch($Lever5.is_active())
	$VanishingWall7.switch(!$Lever5.is_active())
	$VanishingWall8.switch($Lever5.is_active())
	$VanishingWall9.switch($Lever6.is_active())
