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
	
	if lifeDelta <= 0:
		queue_free()

func foodAdd(newFood): # used to add new food together
	for i in 8:
		foodArr[i] += newFood[i]
	foodCheck()
	
func foodCheck(): # used to rename/resprite the food
	foodRename()
	
func foodRename():
	if foodArr == [0,0,0,0,0,0,0,0]:
		foodName = "Nullburger"
		self.texture = load("res://assets/FoodItemSprites/nullburger.png")
		
	elif foodArr == [1,0,0,0,0,0,0,0]:
		foodName = "Bread"
		self.texture = load("res://assets/FoodItemSprites/bread.png")
	elif foodArr == [0,1,0,0,0,0,0,0]:
		foodName = "Meat"
		self.texture = load("res://assets/FoodItemSprites/meat.png")
	elif foodArr == [0,0,1,0,0,0,0,0]:
		foodName = "Lettuce"
		self.texture = load("res://assets/FoodItemSprites/lettuce.png")
	elif foodArr == [0,0,0,1,0,0,0,0]:
		foodName = "Tomato"
		self.texture = load("res://assets/FoodItemSprites/tomato.png")
	elif foodArr == [0,0,0,0,1,0,0,0]:
		foodName = "Cheese"
		self.texture = load("res://assets/FoodItemSprites/cheese.png")
	elif foodArr == [0,0,0,0,0,1,0,0]:
		foodName = "Noodle"
		self.texture = load("res://assets/FoodItemSprites/noodle.png")
	elif foodArr == [0,0,0,0,0,0,1,0]:
		foodName = "Potato"
		self.texture = load("res://assets/FoodItemSprites/potato.png")
	elif foodArr == [0,0,0,0,0,0,0,1]:
		foodName = "Banana"
		self.texture = load("res://assets/FoodItemSprites/banana.png")
		
	elif foodArr == [1,1,1,1,0,0,0,0]:
		foodName = "Deluxeburger"
		self.texture = load("res://assets/FoodItemSprites/deluxeburger.png")
	elif foodArr == [1,1,1,1,1,0,0,0]:
		foodName = "Cheluxeburger"
		self.texture = load("res://assets/FoodItemSprites/cheluxeburger.png")
	elif foodArr == [1,1,0,0,0,0,0,0]:
		foodName = "Hamburger"
		self.texture = load("res://assets/FoodItemSprites/hamburger.png")
	elif foodArr == [1,1,0,0,1,0,0,0]:
		foodName = "Cheeseburger"
		self.texture = load("res://assets/FoodItemSprites/cheeseburger.png")
	elif foodArr == [0,0,1,1,0,0,0,0]:
		foodName = "Salad"
		self.texture = load("res://assets/FoodItemSprites/salad.png")
	elif foodArr == [1,0,1,1,0,0,0,0]:
		foodName = "Veganburger"
		self.texture = load("res://assets/FoodItemSprites/veganburger.png")
	elif foodArr == [1,0,1,1,1,0,0,0]:
		foodName = "Veggieburger"
		self.texture = load("res://assets/FoodItemSprites/veggieburger.png")
	elif foodArr == [1,0,0,1,1,0,0,0]:
		foodName = "Cheese Pizza"
		self.texture = load("res://assets/FoodItemSprites/cheesepizza.png")
	elif foodArr == [1,1,0,1,1,0,0,0]:
		foodName = "Pepperoni Pizza"
		self.texture = load("res://assets/FoodItemSprites/pepperonipizza.png")
	elif foodArr == [0,1,1,1,0,0,0,0]:
		foodName = "Plantburger"
		self.texture = load("res://assets/FoodItemSprites/plantburger.png")
	elif foodArr == [1,0,0,0,1,0,0,0]:
		foodName = "Grilled Cheese"
		self.texture = load("res://assets/FoodItemSprites/grilledcheese.png")
	elif foodArr == [1,0,0,0,0,0,0,1]:
		foodName = "Banana Bread"
		self.texture = load("res://assets/FoodItemSprites/bananabread.png")
	elif foodArr == [0,1,0,1,0,0,0,0]:
		foodName = "Chili"
		self.texture = load("res://assets/FoodItemSprites/chili.png")
	elif foodArr == [0,0,0,0,1,1,0,0]:
		foodName = "Mac N Cheese"
		self.texture = load("res://assets/FoodItemSprites/macncheese.png")
	elif foodArr == [0,1,0,0,0,1,0,0]:
		foodName = "Chicken Noodle"
		self.texture = load("res://assets/FoodItemSprites/chickennoodle.png")
	elif foodArr == [0,0,0,1,0,1,0,0]:
		foodName = "Pasta"
		self.texture = load("res://assets/FoodItemSprites/pasta.png")
	elif foodArr == [0,1,0,1,0,1,0,0]:
		foodName = "Spaghetti"
		self.texture = load("res://assets/FoodItemSprites/spaghetti.png")
	elif foodArr == [0,0,0,1,1,1,0,0]:
		foodName = "Lasagna"
		self.texture = load("res://assets/FoodItemSprites/lasagna.png")
	elif foodArr == [0,1,0,0,1,0,1,0]:
		foodName = "Poutine"
		self.texture = load("res://assets/FoodItemSprites/poutine.png")
	elif foodArr == [0,0,0,0,1,0,1,0]:
		foodName = "Baked Potato"
		self.texture = load("res://assets/FoodItemSprites/bakedpotato.png")
	elif foodArr == [1,1,1,1,1,1,1,1]:
		foodName = "Everythingburger"
		self.texture = load("res://assets/FoodItemSprites/everythingburger.png")
