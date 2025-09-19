extends CanvasLayer

export (PackedScene) var Slot
var inv_pos = 130
var inventory = []
var ammos = 0
var title_screen = null

func _ready() -> void:
	var load_thread = Thread.new()
	load_thread.start(self,"load_title")
	if get_node("../LevelController").get_child(0).name == "Level10":
		show_boss_health()
		$boss_background_health/Label.text = "Totem"
	else:
		hide_boss_health()
	$Pause/Return.connect("pressed",$".","return_pressed")
	$Pause/Title.connect("pressed",$".","title_pressed")
	$Pause/Quit.connect("pressed",$".","quit_pressed")
	$GameOver/Quit.connect("pressed",$".","quit_pressed")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		$Pause.visible = get_tree().paused

func update_health(current):
	$background_health/current_health.value = current
	$Label.text = str(current)

func update_max_health(new):
	$background_health.max_value = new
	$background_health.value = new
	$background_health/current_health.max_value = new
	$background_health/current_health.value = new
	$background_health.rect_scale.x = new/100
	$background_health/current_health.rect_scale.x = new/100
	$Label.text = str(new)


func add_inventory_slot():
	var slot_instance = Slot.instance()
	$Inventory.add_child(slot_instance)
	slot_instance.position.x = inv_pos
	inv_pos += 30

func get_inventory(inv):
	inventory = inv

func update_inventory(selected):
	var slots = $Inventory.get_children()
	var count = 1
	for i in range(inventory.size()):
		slots[i].emptyContents()
		if (inventory[i][0] != "Nothing"):
			slots[i].setContents(inventory[i][0],inventory[i][1])
		slots[i].delarge()
		count += 1
	#slots[0].emptyContents()
	#slots[0].setContents(inventory[selected-1][0],inventory[selected-1][1])
	slots[selected].enlarge()

func add_ammo():
	ammos += 1
	var new_sprite = Sprite.new()
	new_sprite.name = "AmmoSprite"+str(ammos)
	new_sprite.texture = load("res://assets/ammo.png")
	new_sprite.position.x += (ammos*30)-30
	$AmmoContainer.add_child(new_sprite)

func remove_ammo():
	for child in $AmmoContainer.get_children():
		$AmmoContainer.remove_child(child)
	ammos -= 1
	for i in range(ammos):
		var new_sprite = Sprite.new()
		new_sprite.name = "AmmoSprite"+str(i)
		new_sprite.texture = load("res://assets/ammo.png")
		new_sprite.position.x += i*30
		$AmmoContainer.add_child(new_sprite)

func update_gold(amount):
	$GoldLabel.text = "Gold: "+str(amount)

func infect():
	#1e7a14 derfault
	$background_health/current_health.modulate = Color.indigo


func hide_boss_health():
	$boss_background_health.visible = false

func show_boss_health():
	$boss_background_health.visible = true

func update_boss_health(value):
	$boss_background_health/boss_current_health.value = value*500


func return_pressed(text):
	get_tree().paused = !get_tree().paused
	$Pause.visible = get_tree().paused

func title_pressed(text):
	if title_screen != null:
		get_tree().paused = !get_tree().paused
		$Pause.visible = get_tree().paused
		get_tree().change_scene_to(title_screen)

func quit_pressed(text):
	get_tree().quit()

func load_title():
	title_screen = load("res://src/UI/Title_Screen.tscn")

func game_over():
	$AnimationPlayer2.play("game_over")
	get_tree().paused = !get_tree().paused
