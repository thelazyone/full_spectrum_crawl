extends ColorRect

var buff_handles = []


func _ready():
	%CloseBtn.pressed.connect(_on_close)
	
	visible = true
	z_index = 99
	
	# Ensure it processes during pause
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	get_tree().paused = true
	
	update_buffs()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%XpLabel.text = "Current XP: " + str(GlobalVars.player_xp - GlobalVars.player_used_xp)
	pass

func update_buffs():
	
	# Using the information in the global vars, redrawing the boxes.
	
	# Using a model-view in the future (TODO) for now hardcoded.
	
	var buff_template = preload("res://ui/buff_box.tscn")
	
	clear_buff_handles()

	for buff_idx in range (3):
		var buff_str : String
		match buff_idx:
			0: buff_str = "Sniper"
			1: buff_str = "Bomb"
			2: buff_str = "Reserve"
		var local_buff = buff_template.instantiate()
		local_buff.setup(buff_str, GlobalVars.buff_levels[buff_idx], GlobalVars.buff_costs[buff_idx])
		%BuffList.add_child(local_buff)
		buff_handles.append(local_buff)
		local_buff.bind_buy_button(upgrade_buff.bind(buff_idx))

func upgrade_buff(index : int):
	GlobalVars.buff_levels[index] += 1
	GlobalVars.player_used_xp += GlobalVars.buff_costs[index]
	GlobalVars.buff_costs[index] *= 1.25
	update_buffs()	

func clear_buff_handles():
	for handle in buff_handles:
		handle.queue_free()
	buff_handles.clear()

func _on_close():
	print("Closed issued!")
	get_tree().paused = false
	_cleanup()
	
func _cleanup():
	if get_tree() and is_instance_valid(get_tree()):
		queue_free()
