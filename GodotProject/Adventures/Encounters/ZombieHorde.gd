extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["strength"] >= 3 && hero.stats["stamina"] >= 2):
		summary += "I slayed many zombies."
		outcome = "success"
	else:
		summary += "I got devoured by zombies."
		outcome = "death"
		
	return [summary, outcome]
