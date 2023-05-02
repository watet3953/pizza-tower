extends Node2D

@onready var order = [0,0,0,0,0,0,0,0]
@export var hasOrder : bool = false

var rng = RandomNumberGenerator.new()
@onready var newOrder : float = 2.0
@onready var chance : int = 0

@onready var orderName : String = $Back/Label.text

@onready var orderImage : Sprite2D = $Back/Order

var orderDetails = []

func _process(delta):
	
	if not hasOrder:
		newOrder -= delta
	
	if newOrder <= 0:
		rng.randomize()
		chance = rng.randi_range(1, 4)
	
	if chance >= 1 and chance <= 3:
		hasOrder = true
	if chance == 4:
		newOrder = 2.0
		chance = 0
	
	if hasOrder and order == [0,0,0,0,0,0,0,0]:
		rng.randomize()
		var orderNum = rng.randi_range(0, GameManager.ordersArr.size() - 1)
		for i in 8:
			order[i] = GameManager.ordersArr[rng.randi_range(0, orderNum)][i]
		orderDetails = GameManager.foodCheck(order, orderName, orderImage)
		print(orderDetails[0], ", ", orderDetails[1].texture)
	
	if hasOrder and order != [0,0,0,0,0,0,0,0]:
		$Back.show()
		orderImage.texture = orderDetails[1].texture
		orderName = orderDetails[0]
	else:
		$Back.hide()
		orderImage.texture = null
		orderName = ""

func _on_area_2d_body_entered(body):
	if body is Player:
		for i in 3:
			if body.itemsHeld[i] != null and body.itemsHeld[i] is FoodItem:
				if body.itemsHeld[i].foodArr == order:
					body.itemsHeld[i] = null
					order = null
					hasOrder = false
					newOrder = 15.0
