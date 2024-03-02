extends Node
class_name sell_phase

static var finished_choosing_items = false

static func choose_location_phase(location_grid: GridContainer, textbox: Node):
	var button
	for child in location_grid.get_children():
		location_grid.remove_child(child)
	for location: I_Location in util.locations_list:
		button = Button.new()
		button.text = location.location_name
		button.mouse_entered.connect(
			func():
				textbox.text = "Click to set up shop\n" + location.location_to_string()
		)
		button.mouse_exited.connect(
			func():
				textbox.text = ""
		)
		button.pressed.connect(
			func():
				if(!Player.pay_setup_price(location, location.actual_shop_setup_price)):
					return
				for child in location_grid.get_children():
					location_grid.remove_child(child)
				game_state.location_chosen = true
				textbox.text = "You chose: " + location.location_name + "!\nIn a few moments, you will start selling..."
		)
		location_grid.add_child(button)

static func choose_items_to_sell(player_inventory: GridContainer, textbox: Node, items: Dictionary):
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
		button.pressed.connect(
			func():
				Player.toggle_item_sell(item_key)
		)
		player_inventory.add_child(button)
	add_button_to_finish_choosing_items(player_inventory)
	
static func add_button_to_finish_choosing_items(player_inventory: GridContainer):
	var button = Button.new()
	button.text = "Finish choosing items"
	button.pressed.connect(
		func(): 
			finish_choosing_items()
	)
	player_inventory.add_child(button)

static func finish_choosing_items():
	finished_choosing_items = true

static func check_item_is_interest_location():
	if Player.current_item_to_be_sold == null:
		return
	for item_name: String in Player.location_chosen.current_items_of_interest:
		if item_name == Player.current_item_to_be_sold.item_name:
			Player.sell_chance_multiplier = 1.2
			return
	Player.sell_chance_multiplier = 1.0
