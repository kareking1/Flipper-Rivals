extends Node
class_name buy_phase

static var stock = {}

static func initialize_stock_test():
	for item: I_Item in util.items_list:
		stock[item.item_name] = 5
	return stock

static func add_inventory_button_to_item_grid(item_grid: GridContainer, player_inventory: GridContainer, textbox: Node):
	var button = Button.new()
	button.text = "Show Your Inventory"
	button.pressed.connect(
		func(): 
			populate_inventory_grid_with_amount(item_grid, player_inventory, textbox, Player.inventory)
			item_grid.visible = false
			player_inventory.visible = true
	)
	item_grid.add_child(button)

static func add_market_button_to_inventory_grid(item_grid: GridContainer, player_inventory: GridContainer, textbox: Node):
	var button = Button.new()
	button.text = "Show Market"
	button.pressed.connect(
		func(): 
			populate_item_grid_with_amount(item_grid, player_inventory, textbox)
			item_grid.visible = true
			player_inventory.visible = false
	)
	player_inventory.add_child(button)

static func populate_item_grid_with_amount(item_grid: GridContainer, player_inventory: GridContainer, textbox: Node):
	var button
	var item
	for child in item_grid.get_children():
		item_grid.remove_child(child)
	for item_key: String in stock.keys():
		item = util.get_item_from_name(item_key)
		button = Button.new()
		button.text = item.item_name + "\nAmount: " + str(stock[item_key])
		button.mouse_entered.connect(
			func():
				textbox.text = "Click to Buy!\n" + item.item_to_string()
		)
		button.mouse_exited.connect(
			func():
				textbox.text = ""
		)
		button.pressed.connect(
			func():
				player_buys_stock(item_grid, player_inventory, textbox, item_key, item, item.base_value)
		)
		item_grid.add_child(button)
	add_inventory_button_to_item_grid(item_grid, player_inventory, textbox)
	
static func populate_inventory_grid_with_amount(item_grid: GridContainer, player_inventory: GridContainer, textbox: Node, items: Dictionary):
	var button
	var item
	for child in player_inventory.get_children():
		player_inventory.remove_child(child)
	for item_key: String in items.keys():
		item = util.get_item_from_name(item_key)
		button = Button.new()
		button.text = item.item_name + "\nAmount: " + str(items[item_key])
		button.mouse_entered.connect(
			func():
				textbox.text = item.item_to_string()
		)
		button.mouse_exited.connect(
			func():
				textbox.text = ""
		)
		player_inventory.add_child(button)
	add_market_button_to_inventory_grid(item_grid, player_inventory, textbox)
	
static func player_buys_stock(item_grid: GridContainer, player_inventory: GridContainer, textbox: Node, item_key: String, item: I_Item, price: int):
	if(!Player.buy_item(item, price)):
		return
	stock[item_key] -= 1
	if stock[item_key] == 0:
		stock.erase(item_key)
	populate_item_grid_with_amount(item_grid, player_inventory, textbox)
