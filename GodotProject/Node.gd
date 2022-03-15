extends Node

enum OUTCOME{
	success,
	escape,
	death
}

var level = 1

var outcome
var summary = ""

export(String, MULTILINE) var description = ""
export var encounters = []

func start_adventure(hero):
	for encounter in encounters:
		var result = encounter.instance().encounter(hero)
		summary += result[0]
		outcome = result[1]
		if (!(outcome == OUTCOME.success)):
			return [summary, outcome]
	return [summary, outcome]
