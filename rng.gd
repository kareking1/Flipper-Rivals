extends Node2D 
class_name rng_system
static var rng = RandomNumberGenerator.new()

static func generate_seed():
	rng.seed = hash("Borbo") #This should just be replaced by the player's actual name when we get that running
	print(rng.randi_range(10000,99999)) #This is written this way so that each number is the same size, if you want to change this remember that
	return rng

static func is_item_sold(chance_modifier: float = 1.0):
	var generated_num = rng.randi_range(1, 10000)
	if generated_num * chance_modifier >= 9900:
		return true
	return false

static func get_random_item_player_inventory():
	if Player.inventory.is_empty():
		return null
	var generated_item_num = rng.randi_range(0, Player.inventory.size() - 1)
	var item_name = Player.inventory.keys()[generated_item_num]
	return util.get_item_from_name(item_name)
