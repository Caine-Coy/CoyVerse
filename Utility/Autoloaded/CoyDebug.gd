extends Node

var debug = true
var verbosity = verbosityStates.ALL
enum verbosityStates {ERRORS,INTERESTING_EVENTS,ALL}

func Log(_message : String,_verbosity : verbosityStates):
	if (verbosity >= _verbosity):
		print(_message)

func Error(_message):
	print(str("ERROR: ",_message))
