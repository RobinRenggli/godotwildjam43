extends Node

var outcome
var summary = ""

func encounter(hero):
	if (hero.stats["stamina"] >= 2 && hero.stats["speed"] >= 3):
		hero.base_stats["health"] += 1
		summary += "I won the race! I used the winnings to buy new armor."
		outcome = "success"
	elif (hero.stats["stamina"] < 1):
		summary += "I died of a heart attack."
		outcome = "death"
	else:
		summary += "I finished the race, but came in last."
		outcome = "escape"
		
	return [summary, outcome]
