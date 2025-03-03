# Contains the information to build a map.
class_name Map
extends Node2D

var size : float = 8 # It's all in units, the size of a unit is set in global_vars.gd. 

# Buildings and areas and objectives are all temporary for gameplay use.
var buildings : Array[Rect2]
var spawns : Array[Rect2]
var flags : Array[Vector2]

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
