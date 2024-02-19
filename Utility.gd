class_name Utility
#Everything should be static in this class
static var items_list = [] #List of all items in the game
static var locations_list = [] #List of locations
static var events_list = [] #List of events

static func sort_numerical_ascending(a, b):
	if a[0] < b[0]:
		return true
	return false	
	
static func initialize_static_vars():
	items_list.append(Iron_Sword.new())
	items_list.append(Paddle.new())
	items_list.append(Belt.new())
	items_list.append(Action_Figure.new())
	items_list.append(Airhorn.new())
	items_list.append(Ballista.new())
	items_list.append(Monitor.new())
	items_list.append(Potion_of_Rigidity.new())
	items_list.append(Spoon.new())
	items_list.append(Tungsten_Cube.new())
	locations_list.append(Montreal.new())
	events_list.append(Looming_War.new())
	events_list.append(Peaceful_Times.new())
	events_list.append(Universal_Earthquake.new())

#MIGHT NOT BE NEEDED IN THE END!!!
#This func is unfortunately a work around due to the fact that you
#can't really put custom classes in the keys of dictionaries (will become null)
static func get_item_class_from_item_names(item_name: String):
	match item_name:
		"Action Figure": return Action_Figure
		"Air Horn": return Airhorn
		"Ballista": return Ballista
		"Belt": return Belt
		"Iron Sword": return Iron_Sword
		"Monitor": return Monitor
		"Paddle": return Paddle
		"Potion of Rigidity": return Potion_of_Rigidity
		"Spoon": return Spoon
		"Tungsten Cube": return Tungsten_Cube
		_: return null
