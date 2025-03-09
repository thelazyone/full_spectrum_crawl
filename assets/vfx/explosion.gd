extends Area2D

@export var SPEED = 0
@export var DURATION_MS = 250
@export var DAMAGE = 20
@export var UNIT_ID = 0
@export var NOCLIP_TIME_MS = 0
@export var FACTION = 0

@onready var start_time = Time.get_ticks_msec()

var explosion_radius = 0

func set_faction(faction : int):
	FACTION = faction

func explode(coordinates : Vector2, radius : float, damage : float):
	position = coordinates
	explosion_radius = radius
	DAMAGE = damage
	print("Radius is ", explosion_radius)
	%Collision.scale = Vector2(explosion_radius, explosion_radius)
	%Collision.disabled = false 

func _ready() -> void:
	self.body_entered.connect(_deal_damage)
	pass # Replace with function body.

func _draw() -> void:
	# I set the CircleShape in the CollisionShape to radius 10.
	draw_circle(Vector2(0,0), 10 * explosion_radius, Color.YELLOW)

func _process(delta: float) -> void:
	
	# Check if explosion should disappear
	if Time.get_ticks_msec() - start_time > DURATION_MS:
		queue_free()

func _deal_damage(body):
	if "FACTION" in body and body.FACTION == FACTION: 
		return
	
	if body.has_node("HealthComponent"):
		if body.FACTION != FACTION: 
			# dealing damage to all bodies that entered.
			body.get_node("HealthComponent").receive_damage(DAMAGE)
