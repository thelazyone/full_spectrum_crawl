extends ColorRect

func _ready():
	$VBox/ResumeBtn.pressed.connect(_on_resume_pressed)
	$VBox/QuitBtn.pressed.connect(_on_quit_pressed)

	visible = true
	z_index = 99

	process_mode = Node.PROCESS_MODE_ALWAYS
	
	get_tree().paused = true

func _on_resume_pressed():
	# Remove the pause menu and resume the game.
	get_tree().paused = false
	queue_free()

func _on_quit_pressed():
	# For example, quit to main menu; adjust as needed.
	get_tree().paused = false
	# Signal your global GameManager or change scene directly.
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	queue_free()
