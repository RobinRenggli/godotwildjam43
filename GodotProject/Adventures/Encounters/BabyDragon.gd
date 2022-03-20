extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["fire_resistance"] >= 2 && hero.stats["strength"] >= 2):
		summary += "I slayed the baby dragon."
		outcome = "success"
	elif (hero.stats["fire_resistance"] < 1):
		summary += "I was slain by the baby dragon."
		outcome = "death"
	else:
		summary += "I nearly got killed by the baby dragon but managed to escape."
		outcome = "escape"
		
	return [summary, outcome]
