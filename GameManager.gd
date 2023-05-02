extends Node2D

@export var timerMax = 300.0
var timer = 0.0
@export var timerOn = false

var rng = RandomNumberGenerator.new()

@export var ordersMax = 5
var ordersArr = [[1,1,0,0,0,0,0,0], [0,0,1,1,0,0,0,0], [1,0,1,1,0,0,0,0], [1,1,1,1,0,0,0,0], [0,1,1,1,0,0,0,0], [0,1,0,1,0,0,0,0], 
	[1,1,1,1,1,0,0,0], [1,0,1,1,1,0,0,0], [1,1,0,0,1,0,0,0], [1,0,0,1,1,0,0,0], [1,1,0,1,1,0,0,0], [1,0,0,0,1,0,0,0], [0,1,0,0,1,0,1,0], [0,0,0,0,1,0,1,0],
	[0,0,0,1,0,1,0,0], [0,0,0,0,1,1,0,0], [0,1,0,0,0,1,0,0], [0,1,0,1,0,1,0,0], [0,0,0,1,1,1,0,0]]
var ordersActive = []
@export var ingredientsPerOrder = 3
var day = 5
var foodMax = 2
var orderUpgradeLevel = 4
var orderLevels = [
	[[0,0,1,1,0,0,0,0], [1,0,1,1,0,0,0,0], [1,1,1,1,0,0,0,0], [0,1,1,1,0,0,0,0], [0,1,0,1,0,0,0,0]], # level 1
	[[1,1,1,1,1,0,0,0], [1,0,1,1,1,0,0,0], [1,1,0,0,1,0,0,0], [1,0,0,1,1,0,0,0], [1,1,0,1,1,0,0,0], [1,0,0,0,1,0,0,0]], # level 2
	[[0,1,0,0,1,0,1,0], [0,0,0,0,1,0,1,0]], # level 3
	[[0,0,0,1,0,1,0,0], [0,0,0,0,1,1,0,0], [0,1,0,0,0,1,0,0], [0,1,0,1,0,1,0,0], [0,0,0,1,1,1,0,0]] # level 4
]
var dropoffMax = 151 # amount of DropOff in level

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in orderUpgradeLevel:
		ordersArr.append(orderLevels[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timerOn:
		timer -= delta
		#print(timer)
		if timer < 0:
			print("DAY END")
			timerOn = false
	
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
	day += 1
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
	var chonce = rng.randi_range(1, dropoffMax)
	var chance = rng.randi_range(0, ordersArr.size()-1)
	var order = []
	order.append(chonce)
	order.append(ordersArr[chance])
	spawnOrder(order[1])
	ordersActive.append(order)
	openDropOff(order)
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
	

func openDropOff(order):
	var path = "DropOffs/DropOff"+str(order[0])
	print(path)

func foodCheck(foodArr, foodName, sprite):
	if foodArr == [0,0,0,0,0,0,0,0]:
		foodName = "Nullburger"
		sprite.texture = load("res://assets/FoodItemSprites/nullburger.png")
		
	elif foodArr == [1,0,0,0,0,0,0,0]:
		foodName = "Bread"
		sprite.texture = load("res://assets/FoodItemSprites/bread.png")
	elif foodArr == [0,1,0,0,0,0,0,0]:
		foodName = "Meat"
		sprite.texture = load("res://assets/FoodItemSprites/meat.png")
	elif foodArr == [0,0,1,0,0,0,0,0]:
		foodName = "Lettuce"
		sprite.texture = load("res://assets/FoodItemSprites/lettuce.png")
	elif foodArr == [0,0,0,1,0,0,0,0]:
		foodName = "Tomato"
		sprite.texture = load("res://assets/FoodItemSprites/tomato.png")
	elif foodArr == [0,0,0,0,1,0,0,0]:
		foodName = "Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/cheese.png")
	elif foodArr == [0,0,0,0,0,1,0,0]:
		foodName = "Noodle"
		sprite.texture = load("res://assets/FoodItemSprites/noodle.png")
	elif foodArr == [0,0,0,0,0,0,1,0]:
		foodName = "Potato"
		sprite.texture = load("res://assets/FoodItemSprites/potato.png")
	elif foodArr == [0,0,0,0,0,0,0,1]:
		foodName = "Banana"
		sprite.texture = load("res://assets/FoodItemSprites/banana.png")
		
	elif foodArr == [1,1,1,1,0,0,0,0]:
		foodName = "Deluxeburger"
		sprite.texture = load("res://assets/FoodItemSprites/deluxeburger.png")
	elif foodArr == [1,1,1,1,1,0,0,0]:
		foodName = "Cheluxeburger"
		sprite.texture = load("res://assets/FoodItemSprites/cheluxeburger.png")
	elif foodArr == [1,1,0,0,0,0,0,0]:
		foodName = "Hamburger"
		sprite.texture = load("res://assets/FoodItemSprites/hamburger.png")
	elif foodArr == [1,1,0,0,1,0,0,0]:
		foodName = "Cheeseburger"
		sprite.texture = load("res://assets/FoodItemSprites/cheeseburger.png")
	elif foodArr == [0,0,1,1,0,0,0,0]:
		foodName = "Salad"
		sprite.texture = load("res://assets/FoodItemSprites/salad.png")
	elif foodArr == [1,0,1,1,0,0,0,0]:
		foodName = "Veganburger"
		sprite.texture = load("res://assets/FoodItemSprites/veganburger.png")
	elif foodArr == [1,0,1,1,1,0,0,0]:
		foodName = "Veggieburger"
		sprite.texture = load("res://assets/FoodItemSprites/veggieburger.png")
	elif foodArr == [1,0,0,1,1,0,0,0]:
		foodName = "Cheese Pizza"
		sprite.texture = load("res://assets/FoodItemSprites/cheesepizza.png")
	elif foodArr == [1,1,0,1,1,0,0,0]:
		foodName = "Pepperoni Pizza"
		sprite.texture = load("res://assets/FoodItemSprites/pepperonipizza.png")
	elif foodArr == [0,1,1,1,0,0,0,0]:
		foodName = "Plantburger"
		sprite.texture = load("res://assets/FoodItemSprites/plantburger.png")
	elif foodArr == [1,0,0,0,1,0,0,0]:
		foodName = "Grilled Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/grilledcheese.png")
	elif foodArr == [1,0,0,0,0,0,0,1]:
		foodName = "Banana Bread"
		sprite.texture = load("res://assets/FoodItemSprites/bananabread.png")
	elif foodArr == [0,1,0,1,0,0,0,0]:
		foodName = "Chili"
		sprite.texture = load("res://assets/FoodItemSprites/chili.png")
	elif foodArr == [0,0,0,0,1,1,0,0]:
		foodName = "Mac N Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/macncheese.png")
	elif foodArr == [0,1,0,0,0,1,0,0]:
		foodName = "Chicken Noodle"
		sprite.texture = load("res://assets/FoodItemSprites/chickennoodle.png")
	elif foodArr == [0,0,0,1,0,1,0,0]:
		foodName = "Pasta"
		sprite.texture = load("res://assets/FoodItemSprites/pasta.png")
	elif foodArr == [0,1,0,1,0,1,0,0]:
		foodName = "Spaghetti"
		sprite.texture = load("res://assets/FoodItemSprites/spaghetti.png")
	elif foodArr == [0,0,0,1,1,1,0,0]:
		foodName = "Lasagna"
		sprite.texture = load("res://assets/FoodItemSprites/lasagna.png")
	elif foodArr == [0,1,0,0,1,0,1,0]:
		foodName = "Poutine"
		sprite.texture = load("res://assets/FoodItemSprites/poutine.png")
	elif foodArr == [0,0,0,0,1,0,1,0]:
		foodName = "Baked Potato"
		sprite.texture = load("res://assets/FoodItemSprites/bakedpotato.png")
	elif foodArr == [1,1,1,1,1,1,1,1]:
		foodName = "Everythingburger"
		sprite.texture = load("res://assets/FoodItemSprites/everythingburger.png")
		
	return [foodName, sprite]
