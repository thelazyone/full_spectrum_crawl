extends Node

var game_started = false

var player_xp : int = 10000
var player_used_xp : int = 0
var map_level : int = 1

# Currently hardcoded (TODO CHANGE) values for the buffs.
# 1 is snipe, 2 is bomb, 3 is reserve
var buff_levels = [1, 1, 1]
var buff_costs = [400, 800, 750]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Passing map index when starting the game.
var _prompted_map : int = -1 

func set_map_load_index(index: int):
	_prompted_map = index
	
func get_map_load_index():
	return _prompted_map
