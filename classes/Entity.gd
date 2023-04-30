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

var stunDelta : float = 0.0

var stunned : bool = false

func _ready():
	grab.target_position = Vector2(reach,0)

func _move(direction : Vector2, speed : float):
	if stunned:
		return
	velocity += direction * speed * acceleration
	if velocity.length() > topSpeed:
		velocity = velocity.normalized() * topSpeed
	if speed <= 0.0:
		velocity *= 0.5

func _process(delta):
	if stunned:
		stunDelta -= delta
		if stunDelta <= 0.0:
			stunned = false
	move_and_slide()

func _grab():
	if stunned:
		return
	if heldItem == null:
		_pickUp()
	else:
		_drop()

func _pickUp():
	if grab.is_colliding():
		if grab.get_collider() is Item:
			heldItem = grab.get_collider()
		elif grab.get_collider().get_parent() is Item:
			heldItem = grab.get_collider().get_parent()
		if heldItem != null:
			heldItem.inactive = true
			heldItem.position = Vector2(0,0)
			heldItem.visible = false
			heldItem._catch()
			heldItem.get_parent().remove_child(heldItem)
			add_child(heldItem)

func _drop():
	remove_child(heldItem)
	get_parent().add_child(heldItem)
	heldItem.inactive = false
	heldItem.visible = true
	heldItem._set_collision(heldItem.solid)
	heldItem.global_position = global_position + grab.target_position.rotated(rotation)
	heldItem.linear_velocity = velocity
	heldItem = null

func _force():
	if stunned:
		return
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
		elif grab.get_collider().get_parent() is Item:
			grab.get_collider().get_parent().linear_velocity += Vector2.RIGHT.rotated(rotation) * throwForce

func _stun():
	stunned = true
	stunDelta = 3.0
	
