extends Node2D 

class_name rngsystem

static var rng =  RandomNumberGenerator.new()

static func generate_seed():
	rng.seed = hash("Borbo") #This should just be replaced by the player's actual name when we get that running
	print(rng.randi_range(10000,99999)) #This is written this way so that each number is the same size, if you want to change this remember that
	print(rng.seed)
	return rng

