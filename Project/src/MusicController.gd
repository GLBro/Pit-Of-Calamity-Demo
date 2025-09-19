extends Node2D


onready var music = load("res://assets/w1_music.wav")
var loaded_music = null
var music_files = ["res://assets/w1_music.wav","res://assets/w1_boss.wav"]
var counter = 1
var loading = false
var loading_thread = Thread.new()

func _ready() -> void:
	$AudioStreamPlayer2D.stream = music
	$AudioStreamPlayer2D.play()
	loading = true
	loading_thread.start(self,"load_next_file")
	

func _process(delta: float) -> void:
	if not $AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()


func next_music():
	$AudioStreamPlayer2D.stream = loaded_music
	loading = true

func load_next_file():
	while loading:
		counter += 1
		if counter >= music_files.size():
			counter = music_files.size()-1
		print(music_files[counter])
		loaded_music = load(music_files[counter])
		loading = false
		while not loading:
			var wait = 0
	
