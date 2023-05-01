## Player.gd
## Class for the player-controlled entity.

extends Entity
class_name Player

var moveDirection := Vector2.ZERO
var moveForce : float = 0.0

@onready var slot1 : TextureRect = get_parent().get_node("HUD/TextureRect")
@onready var slot2 : TextureRect = get_parent().get_node("HUD/TextureRect2")
@onready var slot3 : TextureRect = get_parent().get_node("HUD/TextureRect3")

@onready var item1 : Sprite2D = get_parent().get_node("HUD/TextureRect/ItemSprite")
@onready var item2 : Sprite2D = get_parent().get_node("HUD/TextureRect2/ItemSprite")
@onready var item3 : Sprite2D = get_parent().get_node("HUD/TextureRect3/ItemSprite")

var itemImage : Sprite2D = item1

@onready var items = [item1, item2, item3]
var itemsHeld = [null, null, null]

var current : int = 0

func _physics_process(_delta):
	if not stunned:
		look_at(get_global_mouse_position())
		_move(moveDirection,moveForce)

func _input(_event):
	moveDirection = Vector2.ZERO
	moveForce = 0.0
	if Input.is_action_pressed("move_up"):
		moveDirection += Vector2.UP
		moveForce = 1.0
	if Input.is_action_pressed("move_down"):
		moveDirection += Vector2.DOWN
		moveForce = 1.0
	if Input.is_action_pressed("move_left"):
		moveDirection += Vector2.LEFT
		moveForce = 1.0
	if Input.is_action_pressed("move_right"):
		moveDirection += Vector2.RIGHT
		moveForce = 1.0
	moveDirection = moveDirection.normalized()
	_move(moveDirection,moveForce)
	if Input.is_action_just_pressed("grab"):
		_grab()
	if Input.is_action_just_pressed("force"):
		_force()
	if Input.is_key_pressed(KEY_1):
		slot1.modulate = Color8(180, 180, 180, 255)
		slot2.modulate = Color8(255, 255, 255, 255)
		slot3.modulate = Color8(255, 255, 255, 255)
		heldItem = itemsHeld[0]
		current = 0
	if Input.is_key_pressed(KEY_2):
		slot1.modulate = Color8(255, 255, 255, 255)
		slot2.modulate = Color8(180, 180, 180, 255)
		slot3.modulate = Color8(255, 255, 255, 255)
		heldItem = itemsHeld[1]
		current = 1
	if Input.is_key_pressed(KEY_3):
		slot1.modulate = Color8(255, 255, 255, 255)
		slot2.modulate = Color8(255, 255, 255, 255)
		slot3.modulate = Color8(180, 180, 180, 255)
		heldItem = itemsHeld[2]
		current = 2

func _pickUp():
	super()
	if heldItem != null:
		itemsHeld[current] = heldItem
		items[current].texture = heldItem.sprite.texture

func _drop():
	itemsHeld[current] = null
	items[current].texture = null
	super()

func _throw():
	itemsHeld[current] = null
	items[current].texture = null
	super()
