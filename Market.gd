extends Node

var seed #We'll have to find a way to implement an rng seed system
var items_list = [] #List of all items in the game
var locations_list = [] #List of locations for the sell phase
var stock = [] #list of items to buy

#This is how we are going to have to add items I think.
#You can click the arrow directly next to the "func" keyword to minimize the function
func _ready():
	items_list.append(Iron_Sword.new())
	locations_list.append(Montreal.new())
	for item:I_Item in items_list:
		print(item.item_name)
	for loc:I_Location in locations_list:
		print(loc.location_name)

#There's a few things this script needs to do:
#1. Handle making the seed and therefore the rng system of the game
#2. Make a stock every buy phase
#3. Make sure the items and locations have their values sorted out
#4. Display the info to the player
