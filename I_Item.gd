#Might not need this extends
extends Node
class_name  I_Item #Makes this script inheritable

@export var item_name = ""
@export var base_value = 0.0
@export var actual_value = 0.0
@export var umbrella_type = ""
@export var specific_type = ""
@export var traits_list = []
var on_sale = false #Mostly included these two bool vars for if we need to quickly check if an item is changed... make sure to update them!
var sale_percentage = 1.0
var price_increased = false
var price_increase_amount = 0.0

func calculate_final_price():
	actual_value = base_value * sale_percentage + price_increase_amount

func get_item_basic_details():
	return "-Name: " + item_name + "\n-Value: " + str(actual_value) + "\n-Types: " + umbrella_type + ", " + specific_type

func set_values(i_name:String, base_v:float, sale:bool, sale_per:float, price_inc:bool, price_inc_amount:float, u_type:String, s_type:String, traits:Array):
	item_name = i_name
	base_value = base_v
	on_sale = sale
	price_increased = price_inc
	sale_percentage = sale_per
	price_increase_amount = price_inc_amount
	calculate_final_price()
	umbrella_type = u_type
	specific_type = s_type
	for trt:String in traits:
		traits_list.append(trt)

#This is a generic class in which we will extend all of our items.
#Look at "Wooden_Sword" for example.
