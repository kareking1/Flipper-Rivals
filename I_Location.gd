extends Node
class_name I_Location #Look at I_Item.gd for inheritance details

@export var location_name = ""
@export var base_population = 0
@export var actual_population = 0
@export var base_shop_setup_price = 0.0
@export var actual_shop_setup_price = 0.0
@export var current_items_of_interest = []

func get_location_basic_details():
	return "-Name: " + location_name + "\n-Population: " + actual_population + "\n-Shop Setup Price: " + actual_shop_setup_price
	
func get_location_items_of_interest():
	var return_string = ""
	for item:I_Item in current_items_of_interest:
		return_string += "-" + item.item_name + "\n"
	if return_string.is_empty():
		return "No items of particular interest here!"
	return return_string
	
#We are going to need to make a customer script as well,
#but that might not need to be inheritable unless we want
#the same list of customers that we will represent.
