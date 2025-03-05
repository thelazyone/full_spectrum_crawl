extends ReferenceRect

var is_spawned : bool = false
var spawn_rect = get_global_rect()
@export var spawn_margin = 800 # positive margin makes it spawn OUTSIDE the view 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("global rect is ", spawn_rect)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not is_spawned:
		# Check if the left-most part of the rect is 
		if spawn_rect.position.x - spawn_margin < GameState.right_margin:
			_spawn()

func _spawn():
	print("spawning stuff!")
	var curr_rect = spawn_rect
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	%UnitFactory.create_unit_by_type(UnitParams.Types.BUG, curr_rect.get_center(), 0, 2)
	
	
	is_spawned = true
