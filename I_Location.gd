class_name I_Location

var location_name = ""
var base_population = 0
var actual_population = 0
var base_shop_setup_price = 0.0
var actual_shop_setup_price = 0.0
var current_items_of_interest = []

func get_location_basic_details():
	return "-Name: " + location_name + "\n-Population: " + actual_population + "\n-Shop Setup Price: " + actual_shop_setup_price
	
func get_location_items_of_interest():
	var return_string = ""
	for item:I_Item in current_items_of_interest:
		return_string += "-" + item.item_name + "\n"
	if return_string.is_empty():
		return "No items of particular interest here!"
	return return_string
	
func set_values(loc_name: String, base_pop: int, base_shop_price: float, items_of_interest: Array = []):
	location_name = loc_name
	base_population = base_pop
	actual_population = base_pop
	base_shop_setup_price = base_shop_price
	actual_shop_setup_price = base_shop_price
	if items_of_interest.is_empty():
		return
	for interest in items_of_interest:
		current_items_of_interest.append(interest)
	
func get_current_interests():
	return current_items_of_interest
	
func set_current_interests(new_interests: Array):
	current_items_of_interest.clear()
	for interest in new_interests:
		current_items_of_interest.append(interest)
