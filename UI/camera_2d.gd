extends Camera2D

var target_position_x : float = 0 
var start_position_x : float = 0
var command_direction : float = 0 # Expecting it between -1 and 1. 
var mouse_direction: int = 0 # Either -1, 0, 1
const CAMERA_SPEED = 250


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Centering the camera to the current view
	# TODO handle changes of view sizing.
	position = get_viewport().get_visible_rect().size / 2
	target_position_x = position.x
	start_position_x = target_position_x
	
	# Connecting the mouse entering event for movement control.
	%LeftMouseArea.mouse_entered.connect(_on_mouse_change.bind(-1))
	%RightMouseArea.mouse_entered.connect(_on_mouse_change.bind(1))
	%LeftMouseArea.mouse_exited.connect(_on_mouse_change.bind(0))
	%RightMouseArea.mouse_exited.connect(_on_mouse_change.bind(0))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if command_direction != 0:
		position.x = max(start_position_x, position.x + delta * CAMERA_SPEED * command_direction)

func _input(event: InputEvent) -> void:
	
	command_direction = mouse_direction
	
	if Input.is_action_pressed("CameraRight"):
		command_direction += 1
		
	if Input.is_action_pressed("CameraLeft"):
		command_direction -= 1

func _on_mouse_change(value : int):
	mouse_direction = value
