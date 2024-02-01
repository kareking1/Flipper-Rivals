extends I_Item #This is how our scripts will be inherited

#Example func below to show inheritence
func what_is_my_price():
	return actual_value #As you can see, even though we didn't declare it here, we can still use this
	
func _ready():
	item_name = "Wooden Sword"
	base_value = 8.0
	on_sale = false
	price_increased = false
	sale_percentage = 1.0 #For no sale, check calculate_final_price
	price_increase_amount = 0.0
	calculate_final_price()
	#And we now set up our Item

#We could attach this script to a node that has the Icon for this
#and it should be ready to use basically.
