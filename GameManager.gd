extends Node2D

@export var timerMax = 300.0
var timer = 0.0
@export var timerOn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timerOn:
		timer -= delta
		#print(timer)
		if timer < 0:
			print("DAY END")
			timerOn = false
	

func dayStart():
	print("DAY START")
	timer = timerMax
	timerOn = true

func _input(_event): # debug, remove at cleanup
	if Input.is_key_pressed(KEY_T):
		dayStart()
