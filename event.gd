extends Node

@export var affected_types = {} #types this event will affect using key value pairs (type name, discount)
@export var affected_traits = {} #same thing as affected_types but with traits
#if an item falls within multiple types and traits, use diminishing returns (apply highest discount and then apply the next discount on the result of the previous one)
@export var event_name = "" #name of the event i.e. natural disaster (affects price of non-perishable foods for example), war time (affects price of weapons)
@export var description = "" #provides context and describes what items will be affected by the event
@export var market_stock = [] #array of all items on the market
@export var item_list = {} #dictionary of items that fall within certain types or traits, along with their discounts

func fill_list(): #loops through the stock
	for item in market_stock:
		var is_valid = false
		var discount_list = []
		for type in affected_types:
			if item.type == type:
				is_valid = true
				discount_list.append(affected_types[type])
		for trt in affected_traits:
			for item_trt in item.traits_list:
				if item_trt == trt:
					is_valid = true
					discount_list.append(affected_traits[item_trt])
		if is_valid == true:
			item_list += {"Item Name": "value1", item:discount_list}
			

func apply_discounts(): #has placeholder code, will apply sales percentages to items of the types affected by this event
	for type in affected_types:
		print(type)
		

func _init(e_name:String, a_types:Dictionary, a_traits:Dictionary, desc:String, stock:Array):
	event_name = e_name
	affected_types = a_types
	affected_traits = a_traits
	description = desc
	market_stock = stock
