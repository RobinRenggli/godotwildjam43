extends TextureRect

var state = "success"

export var level = 1

var base_stats = {
	"health": 5,
	"strength": 3,
	"stamina": 1,
	"speed": 1,

	"poison_resistance": 0,
	"fire_resistance": 0,
	"magic_resistance": 0,
	"cold_resistance": 0,
}

var stats = {
	"health": 5,
	"strength": 3,
	"luck": 0,
	"stamina": 1,
	"speed": 1,

	"poison_resistance": 0,
	"fire_resistance": 0,
	"magic_resistance": 0,
	"cold_resistance": 0,
}

var next_adventure

var dialog = "Uh, hello. Name is Otto the Ogre. Otto need potions. You are potion man, yes? Then make potion for Otto."

var goodbye = "Otto go smash. Goodbye."

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
	if data["finished"]:
		var potion_effects = data["effects"]
		for key in potion_effects:
			stats[key] += potion_effects[key]
		emit_signal("potion_received")
	
