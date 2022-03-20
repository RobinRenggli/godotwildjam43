extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["fire_resistance"] >= 4 && hero.stats["strength"] >= 4):
		summary += "I slayed the regularly sized dragon."
		outcome = "success"
	elif (hero.stats["fire_resistance"] < 3):
		summary += "I was slain by the regularly sized dragon."
		outcome = "death"
	else:
		summary += "I nearly got killed by the regularly sized dragon but managed to escape."
		outcome = "escape"
		
	return [summary, outcome]
