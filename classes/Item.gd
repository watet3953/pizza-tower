## Item.gd
## Class for items that can be picked up and thrown

extends RigidBody2D
class_name Item

@export var weight : float = 1.0 # weight in units
@export var canStun : bool = false # can the item stun a player when thrown
@export var canTrip : bool = false # can the item knock over a player
@export var solid : bool = false # if an object will collide with the player while on the ground
@export var fragile : bool = false # will the item break when thrown?

var thrown : bool = false

var held : bool = false

var inactive : bool = false

var id : int = 0

var itemName = ""

var fallDelta : float = 0.0

@onready var collider : CollisionShape2D = $Collider
@onready var sprite : Sprite2D = $Sprite
@onready var shadow : Sprite2D = $Shadow

func _ready():
	set_collision_layer_value(1, solid)
	set_collision_mask_value(1, solid)
	shadow.texture = sprite.texture

func _process(delta):
	if thrown:
		fallDelta -= delta
		sprite.global_position = global_position + Vector2(0, -fallDelta * 20)
		if fallDelta <= 0.0:
			thrown = false
			linear_damp = 5.0
			set_collision_layer_value(1, solid)
			set_collision_mask_value(1, solid)
			if fragile:
				queue_free()
		elif fallDelta <= 0.8:
			inactive = false
			set_collision_layer_value(1, true)
			set_collision_mask_value(1, true)

func _craft_item():
	if id == 1:
		if self is FoodItem:
			modulate = Color8(255, 255, 0, 255)
			itemName = "Slippery " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/bananapeel.png")
			itemName = "Banana Peel"
		canTrip = true
	if id == 2:
		if self is FoodItem:
			modulate = Color8(0, 255, 255, 255)
			itemName = "Sharp " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/glass.png")
			itemName = "Glass"
		canStun = true
		fragile = true
	if id == 3:
		if self is FoodItem:
			modulate = Color8(0, 255, 0, 255)
			itemName = "Stinky " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/trash.png")
			itemName = "Trash"
		canStun = true
	if id == 4:
		if self is FoodItem:
			modulate = Color8(130, 130, 255, 255)
			itemName = "Light " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/feather.png")
			itemName = "Feather"
		weight = 0.5
	if id == 5:
		if self is FoodItem:
			modulate = Color8(130, 130, 130, 255)
			itemName = "Heavy " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/metal.png")
			itemName = "Metal"
		weight = 2.0
	if id == 6:
		if self is FoodItem:
			modulate = Color8(50, 50, 50, 255)
			itemName = "Sturdy " + itemName
		else:
			sprite.texture = load("res://assets/ItemSprites/stone.png")
			itemName = "Stone"
		solid = true
	if id >= 7:
		sprite.texture = load("res://assets/ItemSprites/notbob.png")
		itemName = "???"

func _set_collision(toggle : bool):
	set_collision_layer_value(1,toggle)
	set_collision_mask_value(1,toggle)

func _catch():
	thrown = false
	inactive = true
	linear_velocity = Vector2.ZERO
	linear_damp = 5.0
	fallDelta = 0.0
	sprite.global_position = global_position
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)

func _throw(force : float, direction : Vector2):
	thrown = true
	inactive = true
	linear_velocity += direction * force * (1 / weight)
	linear_damp = 0.0
	fallDelta = 1.0
	sprite.global_position = global_position + Vector2(0, -fallDelta * 20)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)


func _on_body_entered(body):
	if not visible or inactive:
		return
	if body is Entity:
		if canStun and thrown and get_collision_layer_value(1):
			body._stun()
		if canTrip:
			body._stun()
	if fragile:
		queue_free()


func _on_interactor_body_entered(body):
	if not visible or inactive:
		return
	if body is Entity:
		if canStun and thrown and get_collision_layer_value(1):
			body._stun()
		if canTrip:
			body._stun()
