class_name  I_Item #Makes this script inheritable

var item_name = ""
var base_value = 0.0
var actual_value = 0.0
var type = ""
var traits_list = []

func calculate_final_price(sale_percentage: float, price_increase_amount: float):
	actual_value = base_value * sale_percentage + price_increase_amount

func get_item_basic_details():
	return "-Name: " + item_name + "\n-Value: " + str(actual_value) + "\n-Type: " + type

func set_values(i_name:String, base_v:float, typ:String, traits:Array):
	item_name = i_name
	base_value = base_v
	actual_value = base_v
	type = typ
	for trt:String in traits:
		traits_list.append(trt)
