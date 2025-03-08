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

func goon_killed(goon):
	print("goon ", goon, " killed")
	kill_count += 1
	xp_count += goon.XP
	current_goons.erase(goon)
	if goon.FACTION in current_goons_per_faction:
		current_goons_per_faction[goon.FACTION].erase(goon)

func get_goons(faction : int = -1):
	if faction < 0: 
		return current_goons
	else:
		if not faction in current_goons_per_faction:
			return current_goons
		return current_goons_per_faction[faction]

func clear():
	current_goons = get_tree().get_nodes_in_group("goons")
	for key in current_goons_per_faction.keys():
		print("Deleting goons for faction ", key)
		current_goons_per_faction[key].clear()
	for goon in current_goons:
		goon.queue_free()
