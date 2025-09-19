extends Node2D

var level = 1
var loaded_level = null
var load_thread = Thread.new()
var loading = true
var music_changes = [10]
var current_level = 1

func _ready() -> void:
	load_thread.start(self,"load_level")

func next_level():
	get_child(0).queue_free()
	get_node("../Player").global_position = Vector2(0,0)
	loaded_level.visible = true
	loaded_level.position = Vector2(0,0)
	loading = true
	if loaded_level.name == "Level10":
		get_node("../GUI").show_boss_health()
	else:
		get_node("../GUI").hide_boss_health()
	current_level += 1
	if current_level in music_changes:
		get_node("../MusicController").next_music()



func load_level():
	while loading:
		level += 1
		var string = "res://src/levels/Level"+str(level)+".tscn"
		var resource = load(string)
		loaded_level = resource.instance()
		loaded_level.visible = false
		loaded_level.position = Vector2(100000,100000)
		add_child(loaded_level)
		loading = false
		get_node("../Player/Node2D/Camera2D").smoothing_enabled = true
		print("loaded")
		while not loading:
			var wait = 0

