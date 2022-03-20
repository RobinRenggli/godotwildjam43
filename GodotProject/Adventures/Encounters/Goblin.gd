extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["strength"] >= 2):
		summary += "I defeated a goblin."
		outcome = "success"
	elif (hero.stats["health"] < 2 and hero.stats["speed"] < 3):
		summary += "I died fighting a goblin."
		outcome = "death"
	else:
		summary += "I got bested by a goblin, but managed to escape."
		outcome = "escape"
		
	return [summary, outcome]
