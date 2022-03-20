extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["magic_resistance"] > 0):
		summary += "I defeated a witch."
		outcome = "success"
	elif (hero.stats["health"] < 2 and hero.stats["speed"] < 1):
		summary += "I died fighting a witch."
		outcome = "death"
	else:
		summary += "I got bested by a witch, but managed to escape."
		outcome = "escape"
		
	return [summary, outcome]
