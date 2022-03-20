extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["strength"] >= 1):
		summary += "I enjoyed my night in the mountains."
		outcome = "success"
	else:
		summary += "I froze to death."
		outcome = "death"
		
	return [summary, outcome]
