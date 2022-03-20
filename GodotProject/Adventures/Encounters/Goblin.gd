extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["poison_resistance"] >= 1):
		summary += "I got rid of the scorpions."
		outcome = "success"
	elif (hero.stats["health"] <= 2):
		summary += "I died of scorpion poison."
		outcome = "death"
	else:
		summary += "I barely survived being poisoned by scorpions."
		outcome = "escape" 
		
	return [summary, outcome]
