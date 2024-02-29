extends Node
class_name event_handler

static var chosen_event: I_Event

static func set_event():
	chosen_event = rng_system.choose_random_event()

static func get_event_text():
	return chosen_event.event_to_string()
	
static func execute_event():
	chosen_event.handle_event_based_variances_for_items()
