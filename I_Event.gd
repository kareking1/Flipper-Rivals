class_name I_Event

var discounted_types = {} #types this event will affect using key value pairs (type name, discount)
var discounted_traits = {} #same thing as affected_types but with traits
var pricier_types = {} #Basically opposite of the two above
var pricier_traits = {}
var event_name = "" #name of the event i.e. natural disaster (affects price of non-perishable foods for example), war time (affects price of weapons)
var description = "" #provides context and describes what items will be affected by the event

func handle_event_based_variances_for_items():
	var item_variances_key_value_pair = {}
	var temp_variances_per_item = []
	for item:I_Item in util.items_list:
		for type in discounted_types.keys():
			if item.type == type:
				temp_variances_per_item.append(discounted_types[type])
		for trt in discounted_traits.keys():
			for item_trt in item.traits_list:
				if item_trt == trt:
					temp_variances_per_item.append(discounted_traits[item_trt])
		#We now have all of the discounts for the items, now check for price increases
		for type in pricier_types.keys():
			if item.type == type:
				temp_variances_per_item.append(pricier_types[type])
		for trt in pricier_traits.keys():
			for item_trt in item.traits_list:
				if item_trt == trt:
					temp_variances_per_item.append(pricier_traits[item_trt])
		
		#We now have all the discounts and price increases
		#Now we attach this list to the item and continue
		item_variances_key_value_pair[item.item_name] = temp_variances_per_item
	
	apply_variances(item_variances_key_value_pair)

func apply_variances(item_variances_key_value_pair: Dictionary):
	for key in item_variances_key_value_pair.keys():
		for item:I_Item in util.items_list:
			if key == item.item_name:
				item.calculate_final_price_multiple_variances(item_variances_key_value_pair[key])

func set_values(e_name: String, e_description: String, discount_types: Dictionary, discount_traits: Dictionary, pricy_types: Dictionary, pricy_traits: Dictionary):
	event_name = e_name
	description = e_description
	discounted_types = discount_types
	discounted_traits = discount_traits
	pricier_types = pricy_types
	pricier_traits = pricy_traits
	
func event_to_string():
	var return_string = ""
	return_string += event_name + "\n" + description + "\nCheaper Types: "
	for typ: String in discounted_types:
		return_string += "[" + typ + "] "
	return_string += "\nCheaper Traits: "
	for trt: String in discounted_traits:
		return_string += "[" + trt + "] "
	return_string += "\nPricier Types: "
	for typ: String in pricier_types:
		return_string += "[" + typ + "] "
	return_string += "\nPricier Traits: "
	for trt: String in pricier_traits:
		return_string += "[" + trt + "] "
	return return_string
