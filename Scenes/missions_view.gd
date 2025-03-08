extends Control

func _ready():
	%BuffsBtn.pressed.connect(_on_buffs_pressed)
	%MainMenuBtn.pressed.connect(_on_main_pressed)
	%Map1Btn.pressed.connect(_on_load_map.bind(1))
	%Map2Btn.pressed.connect(_on_load_map.bind(2))
	%Map3Btn.pressed.connect(_on_load_map.bind(3))
	%CustomizeUnitsBtn.pressed.connect(_on_customize_units)
	
	%XpLabel.text = "Available XP: " + str(GlobalVars.player_xp - GlobalVars.player_used_xp) + "."

func _on_buffs_pressed():
	GlobalWindows.message("Not Implemented Yet. :(", self)
	
func _on_main_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_load_map(index: int):
	print("loading map ", index)
	var dialog = GlobalWindows.message("Do you wanna load this map?", self)
	dialog.ok_pressed.connect(_on_load_map_ok.bind(index))
	# Load is inactive but still visible; optionally show a message.
	
func _on_load_map_ok(index: int):
	
	if index == 1:
		GlobalVars.set_map_load_index(index)
		get_tree().change_scene_to_file("res://scenes/battle_view.tscn")
	
	print("Maps functionality coming soon!", self)
	GlobalWindows.message("Maps functionality coming soon!", self)
	
func _on_customize_units():
	GlobalWindows.message("Units functionality coming soon!", self)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		if not has_node("pause_menu"):
			var pause_menu = preload("res://ui/pause_menu.tscn").instantiate()
			pause_menu.name = "pause_menu"  # So you can check if it already exists
			add_child(pause_menu)
			# Optionally pause the game if desired:
			get_tree().paused = true
