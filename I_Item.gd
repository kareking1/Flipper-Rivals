#Might not need this extends
extends Node
class_name  I_Item #Makes this script inheritable

@export var item_name = ""
@export var base_value = 0.0
@export var actual_value = 0.0
@export var umbrella_genre = ""
@export var specific_genre = ""
var on_sale = false #Mostly included these two bool vars for if we need to quickly check if an item is changed... make sure to update them!
var sale_percentage = 0.0
var price_increased = false
var price_increase_amount = 0.0

func calculate_final_price():
	actual_value = base_value * sale_percentage + price_increase_amount

func get_item_basic_details():
	return "-Name: " + item_name + "\n-Value: " + str(actual_value) + "\n-Genres: " + umbrella_genre + ", " + specific_genre

#This is a generic class in which we will extend all of our items.
#Look at "Wooden_Sword" for example.
