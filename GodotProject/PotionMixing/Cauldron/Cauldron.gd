extends TextureRect

var potion_effects = {}
var nr_ingredients = 0
var nr_bad_ingredients = 0
var RNG

func _ready():
	RNG = RandomNumberGenerator.new()
	RNG.randomize()

func get_drag_data(position):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var data = {
		"effects": potion_effects,
		"finished": true
		}
	var drag_texture = TextureRect.new()
	drag_texture.texture = load("res://PotionMixing/Potions/GreenPotion.png")
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_min_size = drag_texture.texture.get_size()
	drag_texture.rect_size = drag_texture.texture.get_size()
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	
	set_drag_preview(control)
	return data

func can_drop_data(position, data):
	return true

func drop_data(_pos, data):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	add_to_cauldron(data)

func add_to_cauldron(data):
	if not data["finished"]:
		var bad_ingredient = check_bad_ingredient()
		var effects
		if check_explosion():
			explode()
		if not bad_ingredient:
			effects = data["effects"]
			good_ingredient_added()
		else:
			effects = data["negative_effects"]
			nr_bad_ingredients += 1
			bad_ingredient_added()
		for key in effects:
			var value = effects[key]
			if potion_effects.has(key):
				potion_effects[key] += value
			else:
				potion_effects[key] = value
		nr_ingredients += 1
		print(potion_effects)
	else:
		get_node("CauldronBadCauldron").emitting = false

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

func good_ingredient_added():
	var good_effect = get_node("CauldronPotionGoodParticles")
	good_effect.emitting = true

func bad_ingredient_added():
	var bad_effect = get_node("CauldronPotionBadParticles")
	var bad_cauldron = get_node("CauldronBadCauldron")
	bad_effect.emitting = true
	bad_cauldron.emitting = true
	
		
	
	

	

