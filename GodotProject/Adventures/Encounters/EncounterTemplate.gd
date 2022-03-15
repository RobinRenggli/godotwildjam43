extends Node

enum OUTCOME{
	success,
	escape,
	death
}

var outcome
var summary = ""

func encounter(hero):
	return ["I didi", OUTCOME.success]
