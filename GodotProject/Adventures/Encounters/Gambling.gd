extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["luck"] >= 2):
		summary += "I won the game! I used the winnings to buy a new weapon."
		hero.base_stats["strength"] += 1
		outcome = "success"
	elif (hero.stats["luck"] < 0):
		summary += "I tripped and died on my way to the game."
		outcome = "death"
	else:
		summary += "I lost all my money."
		outcome = "escape"
		
	return [summary, outcome]
