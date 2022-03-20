extends TextureRect

var state = "success"

export var level = 1

var base_stats = {
	"health": 3,
	"strength": 2,
	"luck": 1,
	"stamina": 1,
	"speed": 1,

	"poison_resistance": 1,
	"fire_resistance": 1,
	"magic_resistance": 1,
	"cold_resistance": 1,
}

var stats = {
	"health": 3,
	"strength": 2,
	"luck": 1,
	"stamina": 1,
	"speed": 1,

	"poison_resistance": 1,
	"fire_resistance": 1,
	"magic_resistance": 1,
	"cold_resistance": 1,
}

var next_adventure

var dialog = "Oi, are you the new potion seller? I am Silli the dwarf and would like to employ your services."

var goodbye = "Off I go!"

signal potion_received

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func chose_adventure(adventures):
	stats = base_stats.duplicate(false)
	next_adventure = null
	while(true):
		var rand_index = randi() % adventures.size()
		next_adventure = adventures[rand_index]
		if (next_adventure.level >= level):
			break
			
	return next_adventure
	
func go_on_adventure():
	var result = next_adventure.start_adventure(self)
	dialog = result[0]
	state = result[1]

func can_drop_data(position, data):     
	return true
	
func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var potion_effects = data["effects"]
	for key in potion_effects:
		stats[key] += potion_effects[key]
	emit_signal("potion_received")
	
