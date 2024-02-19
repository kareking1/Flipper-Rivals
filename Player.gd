extends Node2D

var loan = -2000
var gold = 50
var inventory = {}

func add(item: I_Item, amount: int = 1):
	inventory[item] = amount

func pay_loan(pay_amount: int):  
	gold -= pay_amount
	loan += pay_amount

