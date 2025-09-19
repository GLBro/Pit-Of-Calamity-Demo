extends ColorRect


export (float) var total_time
export (float) var flicker_time
var flickering = false

func _ready() -> void:
	visible = false

func flicker():
	if not flickering:
		visible = false
		$Flicker_Timer.wait_time = total_time
		$Appear_Timer.wait_time = flicker_time
		$Dissappear_Timer.wait_time = flicker_time
		flickering = true
		$Flicker_Timer.start()
		$Appear_Timer.start()
		$AudioStreamPlayer.play()

func _on_Appear_Timer_timeout() -> void:
	if flickering:
		visible = true
		$Dissappear_Timer.start()

func _on_Dissappear_Timer_timeout() -> void:
	if flickering:
		visible = false
		$Appear_Timer.start()


func _on_Flicker_Timer_timeout() -> void:
	flickering = false
	visible = false
