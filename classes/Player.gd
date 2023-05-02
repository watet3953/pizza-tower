## Player.gd
## Class for the player-controlled entity.

extends Entity
class_name Player

var moveDirection := Vector2.ZERO
var moveForce : float = 0.0

@onready var slot1 : TextureRect = get_parent().get_node("HUD/TextureRect")
@onready var slot2 : TextureRect = get_parent().get_node("HUD/TextureRect2")
@onready var slot3 : TextureRect = get_parent().get_node("HUD/TextureRect3")

@onready var image1 : Sprite2D = get_parent().get_node("HUD/TextureRect/ItemSprite")
@onready var image2 : Sprite2D = get_parent().get_node("HUD/TextureRect2/ItemSprite")
@onready var image3 : Sprite2D = get_parent().get_node("HUD/TextureRect3/ItemSprite")

@onready var label1 : Label = get_parent().get_node("HUD/TextureRect/Label")
@onready var label2 : Label = get_parent().get_node("HUD/TextureRect2/Label")
@onready var label3 : Label = get_parent().get_node("HUD/TextureRect3/Label")

@onready var images = [image1, image2, image3]
@onready var labels = [label1, label2, label3]
@onready var itemsHeld = [null, null, null]

var current : int = 0

var crafting : bool = false
var craft1 : Item = null
var craft2 : Item = null
var pos1 : int = -1
var pos2 : int = -1

func _physics_process(_delta):
	if not stunned:
		look_at(get_global_mouse_position())
		_move(moveDirection,moveForce)
	
	for i in 3:
		if itemsHeld[i] != null:
			images[i].texture = itemsHeld[i]d.sprite.texture
			labels[i].text = itemsHeld[i].itemName
		else:
			images[i].texture = null
			labels[i].text = ""
	
	if crafting and not (craft1 == null or craft2 == null):
		if craft1 is FoodItem and craft2 is FoodItem:
			craft1.foodAdd(craft2)
			craft1.foodCheck()
		elif craft1.id == 0 or craft2.id == 0:
			if craft2 is FoodItem:
				var temp = craft2
				craft2 = craft1
				craft1 = temp
			craft1.id = craft2.id
		else:
			craft1.id = 7
		craft1._craft_item()
		itemsHeld[pos1] = craft1
		images[pos1].texture = craft1.sprite.texture
		images[pos1].modulate = craft1.modulate
		itemsHeld[pos2] = null
		images[pos2].texture = null
		crafting = false
	
	if not crafting:
		craft1 = null
		craft2 = null
		pos1 = -1
		pos2 = -1

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
	if Input.is_key_pressed(KEY_R):
		if not crafting:
			crafting = true
		else:
			crafting = false
	if Input.is_key_pressed(KEY_1):
		slot1.modulate = Color8(180, 180, 180, 255)
		slot2.modulate = Color8(255, 255, 255, 255)
		slot3.modulate = Color8(255, 255, 255, 255)
		label1.show()
		label2.hide()
		label3.hide()
		heldItem = itemsHeld[0]
		current = 0
		if crafting and craft1 == null:
			craft1 = heldItem
			pos1 = 0
		elif crafting and craft2 == null:
			craft2 = heldItem
			pos2 = 0
	if Input.is_key_pressed(KEY_2):
		slot1.modulate = Color8(255, 255, 255, 255)
		slot2.modulate = Color8(180, 180, 180, 255)
		slot3.modulate = Color8(255, 255, 255, 255)
		label1.hide()
		label2.show()
		label3.hide()
		heldItem = itemsHeld[1]
		current = 1
		if crafting and craft1 == null:
			craft1 = heldItem
			pos1 = 1
		elif crafting and craft2 == null:
			craft2 = heldItem
			pos2 = 1
	if Input.is_key_pressed(KEY_3):
		slot1.modulate = Color8(255, 255, 255, 255)
		slot2.modulate = Color8(255, 255, 255, 255)
		slot3.modulate = Color8(180, 180, 180, 255)
		label1.hide()
		label2.hide()
		label3.show()
		heldItem = itemsHeld[2]
		current = 2
		if crafting and craft1 == null:
			craft1 = heldItem
			pos1 = 2
		elif crafting and craft2 == null:
			craft2 = heldItem
			pos2 = 2

func _pickUp():
	super()
	if heldItem != null and not crafting:
		itemsHeld[current] = heldItem
		images[current].texture = heldItem.sprite.texture
		images[current].modulate = heldItem.modulate

func _drop():
	if not crafting:
		itemsHeld[current] = null
		images[current].texture = null
	super()

func _throw():
	if not crafting:
		itemsHeld[current] = null
		images[current].texture = null
	super()
