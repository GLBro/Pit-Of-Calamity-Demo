extends StaticBody2D

export (bool) var start

func _ready() -> void:
	switch(start)

func switch(active):
	if active:
		self.visible = true
		$CollisionShape2D.disabled = false
	else:
		self.visible = false
		$CollisionShape2D.disabled = true
