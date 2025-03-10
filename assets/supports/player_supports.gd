extends Node

var EXPLOSION = null
@export var EXPLOSION_RADIUS = 3
@export var BOMB_DAMAGE = 15
@export var SNIPE_DAMAGE = 50
@export var SNIPE_RADIUS = 0.5

func _ready() -> void:
	EXPLOSION = preload("res://assets/vfx/explosion.tscn").instantiate()

func snipe(coordinates):
	var curr_snipe = EXPLOSION.duplicate()
	add_child(curr_snipe)
	curr_snipe.FACTION = 1 # Player's faction is 1
	print ("calling snipe, with damage ", SNIPE_DAMAGE * _damage_multiplier(GlobalVars.buff_levels[0]))
	curr_snipe.explode(coordinates, SNIPE_RADIUS, SNIPE_DAMAGE * _damage_multiplier(GlobalVars.buff_levels[0]))

func throw_bomb(coordinates : Vector2):
	var curr_bomb = EXPLOSION.duplicate()
	add_child(curr_bomb)
	curr_bomb.FACTION = 1 # Player's faction is 1
	curr_bomb.explode(coordinates, EXPLOSION_RADIUS*_damage_multiplier(GlobalVars.buff_levels[1]), BOMB_DAMAGE * _damage_multiplier(GlobalVars.buff_levels[1]))

func call_reserves(coordinates):
	var spawn_position = %UnitFactory.get_latest_containing_rect_for_faction(1).position
	spawn_position.y = coordinates.y # Spawning them at the right Y coordinate
	spawn_position.x = max(0, spawn_position.x - 500)
	for i in range (5 + GlobalVars.buff_levels[2]):
		%UnitFactory.create_unit_by_type(UnitParams.Types.SOLDIER, spawn_position, 0, 1)

func _damage_multiplier(level) -> float:
	return 1 + 0.5 * level

	pass
