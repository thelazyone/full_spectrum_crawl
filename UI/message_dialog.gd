extends ColorRect

signal ok_pressed

func _ready():
	%CloseBtn.pressed.connect(_on_close)
	%OkBtn.pressed.connect(_on_ok_pressed)
	
	visible = true
	z_index = 99
	
	# Ensure it processes during pause
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	print("Pausing...")
	get_tree().paused = true
	
func set_message(text: String):
	%Label.text = text

func _on_close():
	print("Closed issued!")
	get_tree().paused = false
	_cleanup()

func _on_ok_pressed():
	print("Ok pressed!")
	# Emit the signal so that the caller can react.
	get_tree().paused = false
	emit_signal("ok_pressed")
	call_deferred("_cleanup")
	
func set_ok_only(ok_only : bool):
	%CloseBtn.disabled = ok_only
	
func _cleanup():
	if get_tree() and is_instance_valid(get_tree()):
		queue_free()
