extends Node

enum OUTCOME{
	success,
	escape,
	death
}

var outcome
var summary = ""

func encounter(hero):
	if (hero.strength >= 2):
		summary += "I defeated a goblin."
		outcome = OUTCOME.success
	elif (hero.health < 2):
		summary += "Died fighting a goblin."
		outcome = OUTCOME.death
	else:
		summary += "I got bested by a goblin, but managed to escape."
		outcome = OUTCOME.escape
		
	return [summary, outcome]
