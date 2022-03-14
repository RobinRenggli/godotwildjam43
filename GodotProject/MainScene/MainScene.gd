extends Node2D

var active_hero
onready var TextBox = $TextBox

onready var adventures = [preload("res://Adventures/FightGoblin.tscn").instance()]

func _ready():
	active_hero = $Dwarf
	game_loop()
	
func game_loop():
	TextBox.queue_text(active_hero.dialog)
	var adventure = active_hero.chose_adventure(adventures)
	TextBox.queue_text(adventure.description)
