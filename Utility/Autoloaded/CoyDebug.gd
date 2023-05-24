extends Node

var debug = true
var verbosity = verbosityStates.ALL
enum verbosityStates {ERRORS,INTERESTING_EVENTS,ALL}

#The verbosityState is the Lowest it will be before logging. So ALL will be at Max verbosity
func Log(_message : String,_verbosity : verbosityStates):
	if (verbosity >= _verbosity):
		print(_message)

func Error(_message):
	print(str("ERROR: ",_message))
