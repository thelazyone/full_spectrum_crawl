extends HBoxContainer


func setup(name : String, level: int, cost : int):
	%Label.text = name + " (" + str(level) + ")"
	%BuyBtn.text = "Buy for " + str(cost) + "."
	%BuyBtn.disabled = cost > GlobalVars.player_xp - GlobalVars.player_used_xp

func bind_buy_button(callback : Callable):
	%BuyBtn.pressed.connect(callback)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
