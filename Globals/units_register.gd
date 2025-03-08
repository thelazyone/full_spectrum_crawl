extends Node

var current_goons = []
var current_goons_per_faction = {}
var kill_count : int = 0
var xp_count : int = 0

func update_goons():
	current_goons = get_tree().get_nodes_in_group("goons")
	for goon in current_goons:
		if not goon.FACTION in current_goons_per_faction:
			current_goons_per_faction[goon.FACTION] = []
		current_goons_per_faction[goon.FACTION].append(goon)
	
func add_goon(goon):
	current_goons.append(goon)
	if not goon.FACTION in current_goons_per_faction:
		current_goons_per_faction[goon.FACTION] = []
	current_goons_per_faction[goon.FACTION].append(goon)

func goon_killed(xp : int):
	kill_count += 1
	xp_count += xp

func get_goons(faction : int = -1):
	if faction < 0: 
		return current_goons
	else:
		if not faction in current_goons_per_faction:
			return current_goons
		return current_goons_per_faction[faction]
