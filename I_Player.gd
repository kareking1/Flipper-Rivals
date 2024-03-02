extends Node
class_name I_Player

var loan = Utility.starting_loan
var next_payment = Utility.starting_payment
var gold = Utility.starting_gold
var inventory: Dictionary = {}
var location_chosen: I_Location
var items_to_sell: Array = []

#Returns true if item can be bought
func buy_item(item: I_Item, price: int):
	if gold < price:
		return false
	if inventory.has(item.item_name):
		inventory[item.item_name] = inventory[item.item_name] + 1
		gold -= price
		return true
	inventory[item.item_name] = 1
	gold -= price
	return true
	
func toggle_item_sell(item_key: String):
	if items_to_sell.has(item_key):
		items_to_sell.remove_at(items_to_sell.find(item_key))
		return
	items_to_sell.append(item_key)
	
func pay_setup_price(location: I_Location, price: int):
	if gold < price:
		return false
	location_chosen = location
	gold -= price
	return true
	
func sell_item(item_name: String, buy_amount: int):
	if inventory[item_name] == 1:
		inventory.erase(item_name)
		items_to_sell.remove_at(items_to_sell.find(item_name))
		gold += buy_amount
		return
	inventory[item_name] -= 1
	gold += buy_amount

func pay_loan():  
	gold -= next_payment
	loan -= next_payment
	next_payment += Utility.payment_increase
	if next_payment > loan:
		next_payment = loan
	if loan <= 0:
		return #need a way to show victory
