extends Node2D

@export var foodItem : FoodItem = null
@export var item : Item = null
@export var spawnDelta : float = 0
@export var lifeDelta : float = 0

const NEWFOOD = preload("res://classes/FoodItem.tscn")
const NEWITEM = preload("res://classes/Item.tscn")

var rng = RandomNumberGenerator.new()
var spawnChance : int = 0
var spawnItem : bool = false
var itemChance : int = 0

var foodList = [0, 1, 7, 2, 3, 4, 6, 5]

func _ready():
	rng.randomize()
	spawnDelta = rng.randi_range(4, 8)

func _process(delta):
	# timer for item spawning
	if spawnDelta > 0:
		spawnDelta -= delta
	
	# when timer reaches 0, coinflip if item spawns or not
	if spawnDelta <= 0 and foodItem == null and item == null:
		rng.randomize()
		spawnChance = rng.randi_range(1, 2)
	
	# if item spawns
	if spawnChance == 1:
		spawnItem = true
		spawnChance = 0
	# if item does not spawn
	if spawnChance == 2:
		rng.randomize()
		spawnDelta = rng.randi_range(4, 8)
		spawnChance = 0
	
	# coinflip if item is food or not
	if spawnItem:
		rng.randomize()
		itemChance = rng.randi_range(1, 2)
		spawnItem = false
	
	# if item is food, randomize which base food is spawned
	if itemChance == 1:
		foodItem = NEWFOOD.instantiate()
		get_parent().add_child(foodItem)
		foodItem.inactive = false
		foodItem.visible = true
		foodItem.global_position = global_position
		rng.randomize()
		foodItem.foodArr[foodList[rng.randi_range(0, GameManager.foodMax)]] += 1
		foodItem.foodCheck()
		foodItem.itemName = foodItem.foodName
		rng.randomize()
		lifeDelta = rng.randi_range(20, 24)
		itemChance = 3
	# if item is not food, randomize which base item is spawned
	if itemChance == 2:
		item = NEWITEM.instantiate()
		get_parent().add_child(item)
		item.inactive = false
		item.visible = true
		item.global_position = global_position
		rng.randomize()
		item.id = rng.randi_range(1, 6)
		item._craft_item()
		rng.randomize()
		lifeDelta = rng.randi_range(20, 24)
		itemChance = 4
	
	# if item spawned, start counting down for life time
	if lifeDelta > 0:
		lifeDelta -= delta
	
	# reset timer if player picks up food item
	if itemChance == 3 and foodItem != null and foodItem.held:
		rng.randomize()
		spawnDelta = rng.randi_range(4, 8)
		foodItem = null
		itemChance = 0
		lifeDelta = 0
	# reset timer if player picks up item
	if itemChance == 4 and item != null and item.held:
		rng.randomize()
		spawnDelta = rng.randi_range(4, 8)
		item = null
		itemChance = 0
		lifeDelta = 0
	
	# despawn food item
	if lifeDelta <= 0 and itemChance == 3 and foodItem != null and not foodItem.held:
		get_parent().remove_child(foodItem)
		rng.randomize()
		spawnDelta = rng.randi_range(4, 8)
		foodItem = null
		itemChance = 0
	# despawn item
	if lifeDelta <= 0 and itemChance == 4 and foodItem != null and not item.held:
		get_parent().remove_child(item)
		rng.randomize()
		spawnDelta = rng.randi_range(4, 8)
		item = null
		itemChance = 0
