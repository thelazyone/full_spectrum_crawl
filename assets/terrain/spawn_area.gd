extends ReferenceRect

var is_spawned : bool = false
var spawn_rect = get_global_rect()
@export var spawn_margin = 800 # positive margin makes it spawn OUTSIDE the view 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("global rect is ", spawn_rect)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not is_spawned:
		# Check if the left-most part of the rect is 
		if spawn_rect.position.x - spawn_margin < GameState.right_margin:
			_spawn(GlobalVars.map_level)

# Depending on the level, spawning a different amount of troops
func _spawn(level : int):
	
	# 5 + 3 bugs every level
	_spawn_by_type(UnitParams.Types.BUG, int(5 + 3 * level))
	
	# 0 + 1 tank per level
	_spawn_by_type(UnitParams.Types.TANK, int(1 * level))
	
	# 2 + 2 soldiers per level
	_spawn_by_type(UnitParams.Types.SOLDIER, int(2+ 2 * level))
	
	is_spawned = true

func _spawn_by_type(type: UnitParams.Types, amount : int):
	for i in range (amount):
		var offset = Vector2(randf() * spawn_rect.size.x, randf() * spawn_rect.size.y)
		offset -= spawn_rect.size / 2
		%UnitFactory.create_unit_by_type(type, spawn_rect.get_center() + offset, 0, 2)
	
