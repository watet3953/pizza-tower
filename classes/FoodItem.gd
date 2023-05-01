extends Item
class_name FoodItem

# what is the FoodItem?
@export var foodArr = [0,0,0,0,0,0,0,0] # Bread, Meat, Lettuce, Tomato, Cheese, Noodle, Potato, banana
var foodName = "" # changes dynamically based on foodArr

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func foodAdd(newFood): # used to add new food together
	for i in 8:
		foodArr[i] += newFood[i]
	foodCheck()
	
func foodCheck(): # used to rename/resprite the food
	foodRename()
	foodResprite()
	
func foodRename():
	if foodArr == [0,0,0,0,0,0,0,0]:
		foodName = "Nullburger"
		
	elif foodArr == [1,0,0,0,0,0,0,0]:
		foodName = "Bread"
	elif foodArr == [0,1,0,0,0,0,0,0]:
		foodName = "Meat"
	elif foodArr == [0,0,1,0,0,0,0,0]:
		foodName = "Lettuce"
	elif foodArr == [0,0,0,1,0,0,0,0]:
		foodName = "Tomato"
	elif foodArr == [0,0,0,0,1,0,0,0]:
		foodName = "Cheese"
	elif foodArr == [0,0,0,0,0,1,0,0]:
		foodName = "Noodle"
	elif foodArr == [0,0,0,0,0,0,1,0]:
		foodName = "Potato"
	elif foodArr == [0,0,0,0,0,0,0,1]:
		foodName = "Banana"
		
	elif foodArr == [1,1,1,1,0,0,0,0]:
		foodName = "Deluxeburger"
	elif foodArr == [1,1,1,1,1,0,0,0]:
		foodName = "Cheluxeburger"
	elif foodArr == [1,1,0,0,0,0,0,0]:
		foodName = "Hamburger"
	elif foodArr == [1,1,0,0,1,0,0,0]:
		foodName = "Cheeseburger"
	elif foodArr == [0,0,1,1,0,0,0,0]:
		foodName = "Salad"
	elif foodArr == [1,0,1,1,0,0,0,0]:
		foodName = "Veganburger"
	elif foodArr == [1,0,1,1,1,0,0,0]:
		foodName = "Veggieburger"
	elif foodArr == [1,0,0,1,1,0,0,0]:
		foodName = "Cheese Pizza"
	elif foodArr == [1,1,0,1,1,0,0,0]:
		foodName = "Pepperoni Pizza"
	elif foodArr == [0,1,1,1,0,0,0,0]:
		foodName = "Plantburger"
	elif foodArr == [1,0,0,0,1,0,0,0]:
		foodName = "Grilled Cheese"
	elif foodArr == [1,0,0,0,0,0,0,1]:
		foodName = "Banana Bread"
	elif foodArr == [0,1,0,1,0,0,0,0]:
		foodName = "Chili"
	elif foodArr == [0,0,0,0,1,1,0,0]:
		foodName = "Mac N Cheese"
	elif foodArr == [0,1,0,0,0,1,0,0]:
		foodName = "Chicken Noodle"
	elif foodArr == [0,0,0,1,0,1,0,0]:
		foodName = "Pasta"
	elif foodArr == [0,1,0,1,0,1,0,0]:
		foodName = "Spaghetti"
	elif foodArr == [0,0,0,1,1,1,0,0]:
		foodName = "Lasagna"
	elif foodArr == [0,1,0,0,1,0,1,0]:
		foodName = "Poutine"
	elif foodArr == [0,0,0,0,1,0,1,0]:
		foodName = "Baked Potato"
	elif foodArr == [1,1,1,1,1,1,1,1]:
		foodName = "Everythingburger"

func foodResprite(): # todo
	return
