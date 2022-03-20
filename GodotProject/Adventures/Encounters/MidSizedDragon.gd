extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["fire_resistance"] >= 3 && hero.stats["strength"] >= 3):
		summary += "I slayed the mid sized dragon."
		outcome = "success"
	elif (hero.stats["fire_resistance"] < 2):
		summary += "I was slain by the mid sized dragon."
		outcome = "death"
	else:
		summary += "I nearly got killed by the mid sized dragon but managed to escape."
		outcome = "escape"
		
	return [summary, outcome]
