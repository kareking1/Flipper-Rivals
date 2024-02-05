class_name  I_Item #Makes this script inheritable

var item_name = ""
var base_value = 0.0
var actual_value = 0.0
var type = ""
var traits_list = []

func calculate_final_price(variance_percentage: float):
	actual_value = base_value * variance_percentage
	
func calculate_final_price_multiple_variances(variance_percentages: Array):
	actual_value = base_value
	variance_percentages.sort_custom(Utility.sort_numerical_ascending)
	for variance in variance_percentages:
		actual_value *= variance

func get_item_basic_details():
	return "-Name: " + item_name + "\n-Value: " + str(actual_value) + "\n-Type: " + type

func set_values(i_name:String, base_v:float, typ:String, traits:Array):
	item_name = i_name
	base_value = base_v
	actual_value = base_v
	type = typ
	for trt:String in traits:
		traits_list.append(trt)
