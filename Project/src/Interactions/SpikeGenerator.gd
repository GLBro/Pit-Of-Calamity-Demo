extends Node2D

onready var Spike = load("res://src/Interactions/Spike.tscn")
export (int) var number_of_spikes
var move = 0

func _ready() -> void:
	for i in range(number_of_spikes):
		var instance = Spike.instance()
		instance.global_position.x += move
		add_child(instance)
		move += 32
