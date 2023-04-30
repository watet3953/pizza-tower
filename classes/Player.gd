## Player.gd
## Class for the player-controlled entity.

extends Entity
class_name Player

var moveDirection := Vector2.ZERO
var moveForce : float = 0.0

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
