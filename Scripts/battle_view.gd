extends Control

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



# TODO These functions will be part of a specific .tscn for ability buttons.
# It will also implement a cooldown concept, which for now is going to be hardcoded

func _on_snipe_pressed():
	print("Snipe called!")
	
func _on_bomb_pressed():
	print("Bomb called!")
	
func _on_reserves_pressed():
	print("Reserves called!")
