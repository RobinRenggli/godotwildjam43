extends Node

var level = 1

var outcome
var summary = ""

export(String, MULTILINE) var description = ""
export var encounters = []

func start_adventure(hero):
	for encounter in encounters:
		var result = encounter.instance().encounter(hero)
		summary += result[0]
		outcome = result[1]
		if (!(outcome == "success")):
			return [summary, outcome]
	if(hero.level < level):
		hero.level += 1
		summary += "I leveled up!"
	return [summary, outcome]

