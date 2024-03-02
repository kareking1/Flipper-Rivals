extends Node
class_name game_state

var is_selling_time = false
static var location_chosen = false
@onready var timer: Timer = get_node("Timer")
@onready var gold_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Gold")
@onready var loan_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Loan")
@onready var time_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Time_Display")
@onready var textbox: Label = get_node("Descriptive_Textbox/MarginContainer/MarginContainer/HBoxContainer/Description")
@onready var item_grid: GridContainer = get_node("Top_Screen/MarginContainer/Item_Grid")
@onready var player_inventory: GridContainer = get_node("Top_Screen/MarginContainer/Player_Inventory")
@onready var location_grid: GridContainer = get_node("Top_Screen/MarginContainer/Location_Grid")
@onready var game_start_screen: Label = get_node("Top_Screen/MarginContainer/Game_Start_Screen")
@onready var sell_phase_transition: Label = get_node("Top_Screen/MarginContainer/Sell_Phase_Transition")
@onready var buy_phase_transition: Label = get_node("Top_Screen/MarginContainer/Buy_Phase_Transition")
@onready var event_info: Label = get_node("Top_Screen/MarginContainer/Event_Info")
@onready var game_start_button: Button = get_node("Top_Screen/MarginContainer/Game_Start_Screen/Start_Game_Button")


func _ready():
	util.initialize_static_vars()
	timer.one_shot = true
	game_start_button.pressed.connect(
		start_game
	)

func _process(_delta):
	gold_display.text = "Gold: " + str(Player.gold)
	time_display.text = "Time Left: " + str(timer.time_left).pad_decimals(0)
	loan_display.text = "Loan Left: " + str(Player.loan) + ", Next Payment: " + str(Player.next_payment)
	if location_chosen:
		location_chosen = false
		prepare_item_to_be_sold()
	if sell_phase.finished_choosing_items:
		ongoing_sell_phase()
	if is_selling_time and rng_system.is_item_sold():
		var item_to_sell: I_Item = rng_system.get_random_item_player_sell_inventory()
		if item_to_sell != null:
			Player.sell_item(item_to_sell.item_name, item_to_sell.actual_value * Player.location_chosen.sell_multiplier)

func start_game():
	game_start_screen.visible = false
	game_start_button.disabled = true
	game_start_button.visible = false
	handle_events()
	
func handle_events():
	event_handler.set_event()
	event_info.text = event_handler.get_event_text()
	event_info.visible = true
	event_handler.execute_event()
	timer.start(10)
	timer.timeout.connect(
		start_buy_phase, 4
	)
	
func start_buy_phase():
	event_info.visible = false
	buy_phase_transition.visible = true
	timer.start(4)
	timer.timeout.connect(
		ongoing_buy_phase, 4
	)
	
func ongoing_buy_phase():
	buy_phase_transition.visible = false
	item_grid.visible = true
	buy_phase.initialize_stock_test()
	buy_phase.populate_item_grid_with_amount(item_grid, player_inventory, textbox)
	timer.start(7)
	timer.timeout.connect(
		start_sell_phase, 4
	)

func start_sell_phase():
	item_grid.visible = false
	player_inventory.visible = false
	sell_phase_transition.visible = true
	timer.start(4)
	timer.timeout.connect(
		choose_location_phase, 4
	)
	
func choose_location_phase():
	sell_phase_transition.visible = false
	item_grid.visible = false
	player_inventory.visible = false
	location_grid.visible = true
	sell_phase.choose_location_phase(location_grid, textbox)
	
func prepare_item_to_be_sold():
	player_inventory.visible = true
	sell_phase.choose_items_to_sell(player_inventory, textbox, Player.inventory)

func ongoing_sell_phase():
	sell_phase.finished_choosing_items = false
	sell_phase_transition.visible = false
	location_grid.visible = false
	location_chosen = false
	player_inventory.visible = false
	timer.start(15)
	is_selling_time = true
	timer.timeout.connect(
		pay_loan, 4
	)
	
func pay_loan():
	is_selling_time = false
	Player.pay_loan()
	timer.start(3)
	timer.timeout.connect(
		handle_events, 4
	)
