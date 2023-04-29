## Item.gd
## Class for items that can be picked up and thrown

extends RigidBody2D
class_name Item

@export var weight : float = 1.0 # weight in units
@export var canStun : bool = false # can the item stun a player when thrown
@export var canTrip : bool = false # can the item knock over a player
@export var fragile : bool = false # will the item break when thrown?

var thrown : bool = false

var fallDelta : float = 0.0

@onready var collider : CollisionShape2D = $Collider

func _ready():
	linear_damp = weight

func _process(delta):
	if thrown:
		fallDelta -= delta
		if fallDelta <= 0.0:
			thrown = false
			linear_damp = weight
			if fragile:
				queue_free()
		if fallDelta <= 0.8:
			collider.disabled = false

func _set_collision(toggle : bool):
		collider.disabled = !toggle

func _throw(force : float, direction : Vector2):
	thrown = true
	linear_velocity += direction * force * (1 / weight)
	linear_damp = 0.0
	fallDelta = 1.0
	collider.disabled = true
