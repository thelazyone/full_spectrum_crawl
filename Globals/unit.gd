# Creating custom classes for each type of unit - this is BAD but faster 
# for a prototype.
class_name Unit
extends Node2D

# Units are composed of one or more elements, and have global xp and buffs.
var experience : int = 0 
var count : int = 1
var max_count : int = 5

# Properties for individual elements are not handled here: Hp, Position, are handled locally.
# This implies that there won't be any way to track the state of individuals in a unit.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
