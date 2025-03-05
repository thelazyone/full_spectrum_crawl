extends Control

var map : Resource = null

# Game variables: battle advancement 
# TODO handle both the left area graying out (it's a device, but it's kind of cool) and the 
# right-most area that is not in fog of war (which could be grey or whatevs) 


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
	%SnipeBtn.pressed.connect(_on_snipe_pressed)
	%BombBtn.pressed.connect(_on_bomb_pressed)
	%ReservesBtn.pressed.connect(_on_reserves_pressed)
	
	# Loading the map:
	#var stub_params : MapParams = MapParams.new()
	#map = %MapFactory.create(stub_params)
	#print("created map ", map)
	
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


func _process(delta: float) -> void:
	var player_units_rect = %UnitFactory.get_latest_containing_rect_for_faction(1)
	GameState.right_margin = max(GameState.right_margin, player_units_rect.end.x)

# TODO These functions will be part of a specific .tscn for ability buttons.
# It will also implement a cooldown concept, which for now is going to be hardcoded

func _on_snipe_pressed():
	print("Snipe called!")
	
func _on_bomb_pressed():
	print("Bomb called!")
	
func _on_reserves_pressed():
	print("Reserves called!")
