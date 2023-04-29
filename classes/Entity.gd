## Entity.gd
## base class for all characters

extends CharacterBody2D
class_name Entity

@export var weight : float = 1.0
@export var acceleration : float = 25.0
@export var topSpeed : float = 500.0
@export var style : float = 1.0
@export var reach : float = 100.0
@export var throwForce : float = 250.0

@export var heldMoney : float = 0.0

@export var heldItem : Item

@onready var grab : RayCast2D = $Reach

func _ready():
	grab.target_position = Vector2(reach,0)

func _move(direction : Vector2, speed : float):
	velocity += direction * speed * acceleration
	if velocity.length() > topSpeed:
		velocity = velocity.normalized() * topSpeed
	if speed <= 0.0:
		velocity *= 0.5

func _process(_delta):
	move_and_slide()

func _grab():
	if heldItem == null:
		_pickUp()
	else:
		_drop()

func _pickUp():
	if grab.is_colliding() and grab.get_collider() is Item:
		heldItem = grab.get_collider()
		heldItem.position = Vector2(0,0)
		heldItem.visible = false
		heldItem._set_collision(false)
		heldItem.get_parent().remove_child(heldItem)
		add_child(heldItem)

func _drop():
	remove_child(heldItem)
	get_parent().add_child(heldItem)
	heldItem.visible = true
	heldItem._set_collision(true)
	heldItem.global_position = global_position + grab.target_position.rotated(rotation)
	heldItem.linear_velocity = velocity
	heldItem = null

func _force():
	if heldItem == null:
		_push()
	else:
		_throw()

func _throw():
	remove_child(heldItem)
	get_parent().add_child(heldItem)
	heldItem.visible = true
	heldItem.global_position = global_position
	heldItem.linear_velocity = velocity
	heldItem._throw(throwForce,Vector2.RIGHT.rotated(rotation))
	heldItem = null

func _push():
	if grab.is_colliding():
		if grab.get_collider() is Entity:
			grab.get_collider().velocity += Vector2.RIGHT.rotated(rotation) * throwForce
		elif grab.get_collider() is Item:
			grab.get_collider().linear_velocity += Vector2.RIGHT.rotated(rotation) * throwForce
