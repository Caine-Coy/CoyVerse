extends Node

@onready var starNames = CoyFile.LoadFileCSV("res://CelBody/StarNames.json")
var usedStarNames = []
#Romaniser
var _values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
var _symbols = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I']

func GetStarName():
	var _name
	for i in range(starNames.size()):
		if usedStarNames.find(starNames[i]):
			usedStarNames.append(starNames[i])
			_name = starNames[i]
	return _name

#
func IntToRoman(_number : int):
	var _roman_numeral = ''
	for i in range(_values.size()):
		while _number >= _values[i]:
			_roman_numeral += _symbols[i]
			_number -= _values[i]
	return _roman_numeral
