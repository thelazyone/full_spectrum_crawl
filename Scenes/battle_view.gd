extends Control

var map : Resource = null

enum SupportType {NONE, SNIPE, BOMB, RESERVE}
var prepared_support : SupportType = SupportType.NONE
var map_size = 6300 #6300 # todo this will be variable in the future of course

func get_unit_factory():
	return %UnitFactory

func _ready():
	
	# Connecting buttons
	# TODO the buttons should be actually generated depending on buffs and choices
	# of the player:
	# - Specific Buffs can provide more abilities
	# - Units could provide abilities, that work only if you have a unit on the table
	# - there could be a max amount of abilities you can have, so you gotta pick.
	# For a first MVP it's fine to link them as is, and have the effects called 
	# in here directly.
	print("initializing battle view with map index ", GlobalVars.get_map_load_index())
	%SnipeBtn.pressed.connect(_on_support_pressed.bind(SupportType.SNIPE))
	%BombBtn.pressed.connect(_on_support_pressed.bind(SupportType.BOMB))
	%ReservesBtn.pressed.connect(_on_support_pressed.bind(SupportType.RESERVE))
	
	# Setting the starting and ending point: 
	GameState.left_margin = 0
	GameState.right_margin = get_viewport().get_visible_rect().end.x
	
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, Vector2(30,300), 0, 1)
	
	# Preparing the register to count kills:
	UnitsRegister.xp_count = GlobalVars.player_xp

func _process(delta: float) -> void:
	
	# Periodically update the margins.
	var player_units_rect = %UnitFactory.get_latest_containing_rect_for_faction(1)
	GameState.right_margin = max(GameState.right_margin, player_units_rect.end.x)
	
	# Updating the XP:
	GlobalVars.player_xp = UnitsRegister.xp_count
	%XpLabel.text = "XP: " + str(GlobalVars.player_xp)
	
	# Updating the progression:
	var curr_point = player_units_rect.end.x / map_size
	%ProgressionLabel.text = "Progression: " + str(int(curr_point * 100)) + "%"
	
	# If margin has reached the end of the game, calling it a victory! 
	if curr_point > 1:
		_win()
	
	if UnitsRegister.get_goons(1).is_empty():
		_lose()

func _input(event: InputEvent) -> void:

	if Input.is_action_just_pressed("Debug"):
		Debug.debug_enabled = !Debug.debug_enabled
	
	if Input.is_action_just_pressed("Pause"):
		GlobalWindows.pause(self)
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			
			# If click is done after a support is prepared, using it!
			_handle_click(get_global_mouse_position())
			
func _on_support_pressed(type : SupportType):
	prepared_support = type

func _handle_click(click_position):
	# Getting the button, and setting the current effect.
	match prepared_support:
		
		# Getting the button, and setting the current effect.
		SupportType.NONE: return
		
		# Weapons have different effects AND cooldowns.
		SupportType.SNIPE: 
			_set_cooldown_on_button(%SnipeBtn, 1)
			%PlayerSupports.snipe(click_position)
		SupportType.BOMB:			
			_set_cooldown_on_button(%BombBtn, 3)
			%PlayerSupports.throw_bomb(click_position)
		SupportType.RESERVE: 			
			_set_cooldown_on_button(%ReservesBtn, 5)
			%PlayerSupports.call_reserves(click_position)
	
	# The action has been used, the support is back to NONE
	prepared_support = SupportType.NONE

# cooldown is set, then callign reload.
func _set_cooldown_on_button(button : Node, duration : float):
	button.disabled = true
	var timer = get_tree().create_timer(duration)
	timer.timeout.connect(_reload_support.bind(button))
		
func _reload_support(button):
	button.disabled = false
	
func _win():
	GlobalVars.player_xp += 1000
	GlobalVars.map_level += 1
	
	var dialog = GlobalWindows.message("You Won! 1000 XP for you!", self, true)
	dialog.ok_pressed.connect(_on_win_ok)

func _on_win_ok():
	get_tree().change_scene_to_file("res://scenes/missions_view.tscn")

func _lose():
	var dialog = GlobalWindows.message("You Lost. Try again!", self, true)
	dialog.ok_pressed.connect(_on_lose_ok)

func _on_lose_ok():
	get_tree().change_scene_to_file("res://scenes/missions_view.tscn")
	
func _go_to_main():
	UnitsRegister.clear()
