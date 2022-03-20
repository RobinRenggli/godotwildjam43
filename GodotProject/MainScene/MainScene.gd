extends Node2D

var active_hero
var active_hero_index
onready var TextBox = $TextBox

onready var adventures = [preload("res://Adventures/FightGoblin.tscn").instance()]

onready var heroes = [$PotionMixingLayer/Dwarf, $PotionMixingLayer/Ogre, $PotionMixingLayer/Knight]

func _ready():
	randomize()
	active_hero_index = randi() % 3
	game_loop()
	
func game_loop():
	active_hero = heroes[active_hero_index]
	active_hero.visible = true
	active_hero.get_node("CanvasLayer/Sprite").visible = true
	print(active_hero)
	if (active_hero.state == "death"):
		active_hero.get_node("CanvasLayer/Sprite").modulate = Color(1,1,1,0.5)
		TextBox.queue_text(active_hero.dialog)
		yield(TextBox, "is_empty")
		heroes.remove(active_hero_index)
		active_hero.visible = false
		active_hero.get_node("CanvasLayer/Sprite").visible = false
	else:
		TextBox.queue_text(active_hero.dialog)
		var adventure = active_hero.chose_adventure(adventures)
		TextBox.queue_text(adventure.description)
		yield(active_hero, "potion_received")
		TextBox.queue_text(active_hero.goodbye)
		active_hero.go_on_adventure()
		yield(TextBox, "is_empty")
		active_hero.visible = false
		active_hero.get_node("CanvasLayer/Sprite").visible = false
		active_hero_index = (active_hero_index + 1) % heroes.size()
	game_loop()
	
