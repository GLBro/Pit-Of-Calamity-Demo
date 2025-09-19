extends Node2D

func _process(delta: float) -> void:
	$VanishingWall.switch($Lever.is_active())
	$VanishingWall2.switch($Lever.is_active())
	$VanishingWall3.switch($Lever2.is_active())
	$VanishingWall4.switch($Lever3.is_active())
	$VanishingWall5.switch(($Lever4.is_active() and $Lever5.is_active() and $Lever4.is_active()))
	$VanishingWall6.switch(($Lever4.is_active() or $Lever5.is_active() or $Lever4.is_active()))
