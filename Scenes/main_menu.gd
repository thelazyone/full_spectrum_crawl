extends Control

func _ready():
	$MenuBox/StartButton.pressed.connect(_on_start_pressed)
	$MenuBox/LoadButton.pressed.connect(_on_load_pressed)
	$MenuBox/OptionsButton.pressed.connect(_on_options_pressed)
	$MenuBox/CloseButton.pressed.connect(_on_close_pressed)
	
	# Show a welcome message as an example:
	if not GlobalVars.game_started:
		GlobalVars.game_started = true
	
func _on_start_pressed():
	# Notify GameManager to change to GlobalView
	get_tree().change_scene_to_file("res://scenes/missions_view.tscn")

func _on_load_pressed():
	# Load is inactive but still visible; optionally show a message.
	GlobalWindows.message("Load functionality coming soon!", self)
	
func _on_options_pressed():
	# Load is inactive but still visible; optionally show a message.
	GlobalWindows.message("Options coming soon!", self)

func _on_close_pressed():
	get_tree().quit()
