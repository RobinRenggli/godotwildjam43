extends TextureRect

var state = "success"

export var level = 1

var base_stats = {
	"health": 3,
	"strength": 1,
	"luck": 1,
	"stamina": 2,
	"speed": 2,

	"poison_resistance": 0,
	"fire_resistance": 0,
	"magic_resistance": 0,
	"cold_resistance": 0,
}

var stats = {
	"health": 3,
	"strength": 1,
	"luck": 1,
	"stamina": 2,
	"speed": 2,

	"poison_resistance": 0,
	"fire_resistance": 0,
	"magic_resistance": 0,
	"cold_resistance": 0,
}

var next_adventure

var dialog = "Good day, kind sir. I am in need for potions for my coming adventures. Could you provide me with such?"

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
	print("Knight received")
	emit_signal("potion_received")
	
