## FoodItem.gd
## Class for food items that can be orders

extends Item
class_name FoodItem

# what is the FoodItem?
@export var lifeDelta : int = 600
@export var foodArr = [0,0,0,0,0,0,0,0] # Bread, Meat, Lettuce, Tomato, Cheese, Noodle, Potato, banana
var foodName = "" # changes dynamically based on foodArr

func _process(delta):
	if held:
		lifeDelta = 600
	else:
		lifeDelta -= delta
	
	#if lifeDelta <= 0:
	#	queue_free()

func foodAdd(newFood): # used to add new food together
	for i in 8:
		foodArr[i] += newFood.foodArr[i]
	foodCheck()
	itemName = foodName
	
func foodCheck():
	if foodArr == [0,0,0,0,0,0,0,0]:
		foodName = "Nullburger"
		sprite.texture = load("res://assets/FoodItemSprites/nullburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/nullburger.png")
		
	elif foodArr == [1,0,0,0,0,0,0,0]:
		foodName = "Bread"
		sprite.texture = load("res://assets/FoodItemSprites/bread.png")
		shadow.texture = load("res://assets/FoodItemSprites/bread.png")
	elif foodArr == [0,1,0,0,0,0,0,0]:
		foodName = "Meat"
		sprite.texture = load("res://assets/FoodItemSprites/meat.png")
		shadow.texture = load("res://assets/FoodItemSprites/meat.png")
	elif foodArr == [0,0,1,0,0,0,0,0]:
		foodName = "Lettuce"
		sprite.texture = load("res://assets/FoodItemSprites/lettuce.png")
		shadow.texture = load("res://assets/FoodItemSprites/lettuce.png")
	elif foodArr == [0,0,0,1,0,0,0,0]:
		foodName = "Tomato"
		sprite.texture = load("res://assets/FoodItemSprites/tomato.png")
		shadow.texture = load("res://assets/FoodItemSprites/tomato.png")
	elif foodArr == [0,0,0,0,1,0,0,0]:
		foodName = "Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/cheese.png")
		shadow.texture = load("res://assets/FoodItemSprites/cheese.png")
	elif foodArr == [0,0,0,0,0,1,0,0]:
		foodName = "Noodle"
		sprite.texture = load("res://assets/FoodItemSprites/noodle.png")
		shadow.texture = load("res://assets/FoodItemSprites/noodle.png")
	elif foodArr == [0,0,0,0,0,0,1,0]:
		foodName = "Potato"
		sprite.texture = load("res://assets/FoodItemSprites/potato.png")
		shadow.texture = load("res://assets/FoodItemSprites/potato.png")
	elif foodArr == [0,0,0,0,0,0,0,1]:
		foodName = "Banana"
		sprite.texture = load("res://assets/FoodItemSprites/banana.png")
		shadow.texture = load("res://assets/FoodItemSprites/banana.png")
		
	elif foodArr == [1,1,1,1,0,0,0,0]:
		foodName = "Deluxeburger"
		sprite.texture = load("res://assets/FoodItemSprites/deluxeburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/deluxeburger.png")
	elif foodArr == [1,1,1,1,1,0,0,0]:
		foodName = "Cheluxeburger"
		sprite.texture = load("res://assets/FoodItemSprites/cheluxeburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/cheluxeburger.png")
	elif foodArr == [1,1,0,0,0,0,0,0]:
		foodName = "Hamburger"
		sprite.texture = load("res://assets/FoodItemSprites/hamburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/hamburger.png")
	elif foodArr == [1,1,0,0,1,0,0,0]:
		foodName = "Cheeseburger"
		sprite.texture = load("res://assets/FoodItemSprites/cheeseburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/cheeseburger.png")
	elif foodArr == [0,0,1,1,0,0,0,0]:
		foodName = "Salad"
		sprite.texture = load("res://assets/FoodItemSprites/salad.png")
		shadow.texture = load("res://assets/FoodItemSprites/salad.png")
	elif foodArr == [1,0,1,1,0,0,0,0]:
		foodName = "Veganburger"
		sprite.texture = load("res://assets/FoodItemSprites/veganburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/veganburger.png")
	elif foodArr == [1,0,1,1,1,0,0,0]:
		foodName = "Veggieburger"
		sprite.texture = load("res://assets/FoodItemSprites/veggieburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/veggieburger.png")
	elif foodArr == [1,0,0,1,1,0,0,0]:
		foodName = "Cheese Pizza"
		sprite.texture = load("res://assets/FoodItemSprites/cheesepizza.png")
		shadow.texture = load("res://assets/FoodItemSprites/cheesepizza.png")
	elif foodArr == [1,1,0,1,1,0,0,0]:
		foodName = "Pepperoni Pizza"
		sprite.texture = load("res://assets/FoodItemSprites/pepperonipizza.png")
		shadow.texture = load("res://assets/FoodItemSprites/pepperonipizza.png")
	elif foodArr == [0,1,1,1,0,0,0,0]:
		foodName = "Plantburger"
		sprite.texture = load("res://assets/FoodItemSprites/plantburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/plantburger.png")
	elif foodArr == [1,0,0,0,1,0,0,0]:
		foodName = "Grilled Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/grilledcheese.png")
		shadow.texture = load("res://assets/FoodItemSprites/grilledcheese.png")
	elif foodArr == [1,0,0,0,0,0,0,1]:
		foodName = "Banana Bread"
		sprite.texture = load("res://assets/FoodItemSprites/bananabread.png")
		shadow.texture = load("res://assets/FoodItemSprites/bananabread.png")
	elif foodArr == [0,1,0,1,0,0,0,0]:
		foodName = "Chili"
		sprite.texture = load("res://assets/FoodItemSprites/chili.png")
		shadow.texture = load("res://assets/FoodItemSprites/chili.png")
	elif foodArr == [0,0,0,0,1,1,0,0]:
		foodName = "Mac N Cheese"
		sprite.texture = load("res://assets/FoodItemSprites/macncheese.png")
		shadow.texture = load("res://assets/FoodItemSprites/macncheese.png")
	elif foodArr == [0,1,0,0,0,1,0,0]:
		foodName = "Chicken Noodle"
		sprite.texture = load("res://assets/FoodItemSprites/chickennoodle.png")
		shadow.texture = load("res://assets/FoodItemSprites/chickennoodle.png")
	elif foodArr == [0,0,0,1,0,1,0,0]:
		foodName = "Pasta"
		sprite.texture = load("res://assets/FoodItemSprites/pasta.png")
		shadow.texture = load("res://assets/FoodItemSprites/pasta.png")
	elif foodArr == [0,1,0,1,0,1,0,0]:
		foodName = "Spaghetti"
		sprite.texture = load("res://assets/FoodItemSprites/spaghetti.png")
		shadow.texture = load("res://assets/FoodItemSprites/spaghetti.png")
	elif foodArr == [0,0,0,1,1,1,0,0]:
		foodName = "Lasagna"
		sprite.texture = load("res://assets/FoodItemSprites/lasagna.png")
		shadow.texture = load("res://assets/FoodItemSprites/lasagna.png")
	elif foodArr == [0,1,0,0,1,0,1,0]:
		foodName = "Poutine"
		sprite.texture = load("res://assets/FoodItemSprites/poutine.png")
		shadow.texture = load("res://assets/FoodItemSprites/poutine.png")
	elif foodArr == [0,0,0,0,1,0,1,0]:
		foodName = "Baked Potato"
		sprite.texture = load("res://assets/FoodItemSprites/bakedpotato.png")
		shadow.texture = load("res://assets/FoodItemSprites/bakedpotato.png")
	elif foodArr == [1,1,1,1,1,1,1,1]:
		foodName = "Everythingburger"
		sprite.texture = load("res://assets/FoodItemSprites/everythingburger.png")
		shadow.texture = load("res://assets/FoodItemSprites/everythingburger.png")
	
	else:
		id = 7
		_craft_item()

func get_foodName():
	return foodName
