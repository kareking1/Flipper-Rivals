extends Node2D

var loan = 2000
var next_payment = 100
var gold = 1000
var inventory = {}

func add(item: I_Item, amount: int = 1):
	inventory[item] = amount
	
#Returns true if item can be bought
func buy_item(item: I_Item, price: int):
	if inventory.has(item.item_name) and gold >= price:
		inventory[item.item_name] = inventory[item.item_name] + 1
		gold -= price
		return true
	if gold >= price:
		inventory[item.item_name] = 1
		gold -= price
		return true
	return false

func pay_loan(pay_amount: int):  
	gold -= pay_amount
	loan += pay_amount
