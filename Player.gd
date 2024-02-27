extends Node2D

var loan = 2000
var next_payment = 100
var gold = 1000
var inventory: Dictionary = {}
var location_chosen: I_Location
var current_item_to_be_sold: I_Item
var sell_chance_multiplier = 1.0

func add(item: I_Item, amount: int = 1):
	inventory[item] = amount
	
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
	
func pay_setup_price(location: I_Location, price: int):
	if gold < price:
		return false
	location_chosen = location
	gold -= price
	return true
	
func sell_item(item_name: String, buy_amount: int):
	if inventory[item_name] == 1:
		inventory.erase(item_name)
		gold += buy_amount
		return
	inventory[item_name] -= 1
	gold += buy_amount

func pay_loan():  
	gold -= next_payment
	loan -= next_payment
	next_payment += 200
	if next_payment > loan:
		next_payment = loan
	if loan <= 0:
		return #need a way to show victory
