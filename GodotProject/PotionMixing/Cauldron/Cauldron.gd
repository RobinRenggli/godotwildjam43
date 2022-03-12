extends TextureRect

var potion_effects = {}
var nr_ingredients = 0

func can_drop_data(position, data):
	return true

func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	add_to_cauldron(data)

func add_to_cauldron(data):
	nr_ingredients += 1
	var effects = data["effects"]
	for key in effects:
		var value = effects[key]
		if potion_effects.has(key):
			potion_effects[key] += value
		else:
			potion_effects[key] = value
	print(potion_effects)
