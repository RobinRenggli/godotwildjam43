extends TextureRect

var potion_effects = {}
var nr_ingredients = 0
var nr_bad_ingredients = 0
var RNG

func _ready():
	RNG = RandomNumberGenerator.new()
	RNG.randomize()

func can_drop_data(position, data):
	return true

func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	add_to_cauldron(data)

func add_to_cauldron(data):
	var bad_ingredient = check_bad_ingredient()
	var effects
	if check_explosion():
		explode()
	if not bad_ingredient:
		effects = data["effects"]
	else:
		effects = data["negative_effects"]
		nr_bad_ingredients += 1
	for key in effects:
		var value = effects[key]
		if potion_effects.has(key):
			potion_effects[key] += value
		else:
			potion_effects[key] = value
	nr_ingredients += 1
	print(potion_effects)

func check_bad_ingredient():
	if nr_ingredients < 1:
		return false
	elif nr_ingredients < 3:
		return RNG.randi_range(1, 5) == 1
	elif nr_ingredients < 5:
		return RNG.randi_range(1, 3) == 1
	elif nr_ingredients < 10:
		return RNG.randi_range(1, 2) == 1
	elif nr_ingredients < 15:
		return RNG.randi_range(1, 3) != 1
	else:
		return RNG.randi_range(1, 5) != 1

func check_explosion():
	if nr_bad_ingredients < 3:
		return false
	elif nr_bad_ingredients < 4:
		return RNG.randi_range(1, 5) == 1
	elif nr_bad_ingredients < 5:
		return RNG.randi_range(1, 4) == 1
	elif nr_bad_ingredients < 6:
		return RNG.randi_range(1, 3) == 1
	else:
		return RNG.randi_range(1, 2) == 1

func explode():
	print("EXPLOSION")
