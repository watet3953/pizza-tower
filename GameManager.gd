extends Node2D

@export var timerMax = 300.0
var timer = 0.0
@export var timerOn = false

var rng = RandomNumberGenerator.new()

@onready var itemImage = get_parent().get_node("HUD/TextureRect/ItemSprite")

@export var ordersMax = 5
var ordersArr = [[1,1,0,0,0,0,0,0]]
var ordersActive = []
@export var ingredientsPerOrder = 3
var day = 1
var foodMax = 2
var orderUpgradeLevel = 0
var orderLevels = [
	[[0,0,1,1,0,0,0,0], [1,0,1,1,0,0,0,0], [1,1,1,1,0,0,0,0], [0,1,1,1,0,0,0,0], [0,1,0,1,0,0,0,0]], # level 1
	[[1,1,1,1,1,0,0,0], [1,0,1,1,1,0,0,0], [1,1,0,0,1,0,0,0], [1,0,0,1,1,0,0,0], [1,1,0,1,1,0,0,0], [1,0,0,0,1,0,0,0]], # level 2
	[[0,1,0,0,1,0,1,0], [0,0,0,0,1,0,1,0]], # level 3
	[[0,0,0,1,0,1,0,0], [0,0,0,0,1,1,0,0], [0,1,0,0,0,1,0,0], [0,1,0,1,0,1,0,0], [0,0,0,1,1,1,0,0]] # level 4
]

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
			day += 1
	
	if day == 1:
		foodMax = 2
	elif day == 2:
		foodMax = 4
	elif day == 3:
		foodMax = 5
	elif day == 4:
		foodMax = 6
	elif day == 5:
		foodMax = 7

func dayStart():
	print("DAY START")
	timer = timerMax
	timerOn = true
	ordersActive = []
	for i in ordersMax:
		generateOrder()
	print(ordersActive)

func _input(_event): # debug, remove at cleanup
	if Input.is_key_pressed(KEY_T):
		dayStart()
	if Input.is_key_pressed(KEY_U):
		upgradeOrders()

func upgradeOrders():
	if orderUpgradeLevel < orderLevels.size():
		orderUpgradeLevel += 1
		ordersArr.append_array(orderLevels[orderUpgradeLevel-1])
		print("level:")
		print(orderUpgradeLevel)
	else:
		print("max level")
	

func generateOrder():
	var chance = rng.randi_range(0, ordersArr.size()-1)
	spawnOrder(ordersArr[chance])
	ordersActive.append(ordersArr[chance])
	#print(ordersActive)
	
func spawnOrder(order):
	for i in order.size():
		if order[i] > 0:
			for j in ingredientsPerOrder:
				spawnFoodItem(createBaseIngredient(i))
	
func createBaseIngredient(num):
	var newBase = [0,0,0,0,0,0,0,0]
	newBase[num] += 1
	return newBase

func spawnFoodItem(food):
	print(food)
	# this needs to spawn at a random position
	

