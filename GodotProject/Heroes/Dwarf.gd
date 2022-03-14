extends TextureRect

export var level = 1

export var health = 3
export var strength = 1
export var luck = 1
export var stamina = 1
export var speed = 1

export var poison_resistance = 0
export var fire_resistance = 0
export var magic_resistance = 0
export var cold_resistance = 0

var next_adventure

var dialog = "Oi, are you the new potion seller? I am Silli the dwarf and would like to employ your services."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func chose_adventure(adventures):
	next_adventure = null
	while(true):
		var rand_index = randi() % adventures.size()
		next_adventure = adventures[rand_index]
		if (next_adventure.level >= level):
			break
			
	return next_adventure
	
func go_on_adventure():
	pass
