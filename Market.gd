extends Node

var seed = rngsystem.generate_seed() #We'll have to find a way to implement an rng seed system
var items_list = [] #List of all items in the game
var locations_list = [] #List of locations for the sell phase
var stock = {} #list of items to buy

#This is how we are going to have to add items I think.
#You can click the arrow directly next to the "func" keyword to minimize the function
func _ready():
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


	var temp_items_dic = {'Iron_Sword': 2}
	#temp_items_dic[T_I] = 1
	#add_items_to_stock(temp_items_dic)
	#print(stock)
	print(temp_items_dic)
	#for item:I_Item in items_list:
		#print(item.item_name)
	#for loc:I_Location in locations_list:
		#print(loc.location_name)
	generate_buttons()
	#for _i in self.get_children():
		#print(_i)

func get_item_from_game_list(i_name: String):
	for item:I_Item in items_list:
		if item.item_name == i_name:
			return item
			
func get_item_from_stock(i_name: String):
	for item:I_Item in stock:
		if item.item_name == i_name:
			return item #We also need to probably get the amount in stock
	return null
			
func get_location_from_list(l_name: String):
	for location:I_Location in locations_list:
		if location.location_name == l_name:
			return location

func add_items_to_stock(items_amount_dict:Dictionary):
	stock = items_amount_dict
	
#func reduce_item_amount(item_name)

func list_to_string(item:I_Item):
	var list_str = ""
	for trt in item.traits_list:
		list_str += "[" + trt + "] "
	return list_str

#There's a few things this script needs to do:
#1. Handle making the seed and therefore the rng system of the game
#2. Make a stock every buy phase
#3. Make sure the items and locations have their values sorted out
#4. Display the info to the player

func generate_buttons():
	var counter = 0
	var x = 20
	var y = 20
	for item:I_Item in items_list:
		var button = Button.new()
		button.text = item.item_name
		button.position = Vector2(x,y)
		button.size = Vector2(100, 70)
		button.mouse_entered.connect(func(): 	get_node("Textbox/MarginContainer/MarginContainer/HBoxContainer/Description").text = item.item_name + "\nType: " + item.type + "\nTraits: " + list_to_string(item) + "\nBase Price: $" + str(item.base_value).pad_decimals(2))
		button.mouse_exited.connect(func(): 	get_node("Textbox/MarginContainer/MarginContainer/HBoxContainer/Description").text = "")
		add_child(button)
		counter += 1
		if not x >= 1000:
			x += button.size.x + 20
		else:
			x = 20
			y += 100
