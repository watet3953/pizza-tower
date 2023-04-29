# Entity.gd
# base class for all characters

extends CharacterBody2D
class_name Entity

@export var weight : float = 1.0
@export var acceleration : float = 1.0
@export var topSpeed : float = 1.0
@export var style : float = 1.0
@export var reach : float = 1.0
@export var throwForce : float = 1.0

@export var heldMoney : float = 0.0

@export var heldItem : Item

@onready var grab : RayCast2D = $Reach

func _ready():
	grab.target_position = Vector2(0,reach)

# TODO MOVEMENT

func _grab():
	if heldItem == null:
		_pickUp()
	else:
		_drop()

func _pickUp():
	if grab.is_colliding() and grab.get_collider() is Item:
		heldItem = grab.get_collider()
		add_child(heldItem)
		heldItem.position = Vector2(0,0)
		heldItem.visible = false

func _drop():
	heldItem.visible = true
	get_parent().add_child(heldItem)
	heldItem.global_position = global_position + grab.target_position.rotated(rotation)
	heldItem = null

func _force():
	if heldItem == null:
		_push()
	else:
		_throw()

func _throw():
	heldItem.visible = true
	get_parent().add_child(heldItem)
	heldItem._throw(throwForce,Vector2.UP.rotated(rotation))
	heldItem = null

func _push():
	if grab.is_colliding():
		if grab.get_collider() is Entity:
			grab.get_collider().velocity += Vector2.UP.rotated(rotation) * throwForce
