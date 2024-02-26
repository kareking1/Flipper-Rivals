extends Node

@onready var timer: Timer = get_node("Timer")
@onready var gold_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Gold")
@onready var loan_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Loan")
@onready var time_display: Label = get_node("Top_Screen/MarginContainer/MarginContainer/Top_Panel/Time_Display")
@onready var textbox: Label = get_node("Descriptive_Textbox/MarginContainer/MarginContainer/HBoxContainer/Description")
@onready var item_grid: GridContainer = get_node("Top_Screen/MarginContainer/Item_Grid")
@onready var player_inventory: GridContainer = get_node("Top_Screen/MarginContainer/Player_Inventory")
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

func start_game():
	game_start_screen.visible = false
	game_start_button.disabled = true
	game_start_button.visible = false
	buy_phase_transition.visible = true
	timer.start(8)
	timer.timeout.connect(
		start_buy_phase
	)
	
func start_buy_phase():
	buy_phase_transition.visible = false
	item_grid.visible = true
	buy_phase.initialize_stock_test()
	buy_phase.populate_item_grid_with_amount(item_grid, player_inventory, textbox)
	timer.start(15)
	timer.timeout.disconnect(
		start_buy_phase
	)
	timer.timeout.connect(
		start_sell_phase
	)

func start_sell_phase():
	pass
