extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["poison_resistance"] >= 3):
		summary += "I survived the deadly gas."
		outcome = "success"
	else:
		summary += "I succumbed to the poison."
		outcome = "death"
		
	return [summary, outcome]
