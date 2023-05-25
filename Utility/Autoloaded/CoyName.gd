extends Node

@onready var starNames = CoyFile.LoadFileCSV("res://CelBody/StarNames.json")
var usedStarNames = []
#Romaniser
var roman_numerals = {'M' : 1000, 'CM' : 90, 'D' : 500, 'CD' : 400, 'C' : 100, 'XC' : 90, 'L' : 50, 'XL' : 40, 'X' :10, 'IX' : 9, 'V' : 5, 'IV' : 4, 'I' : 1}
var greek_letters = ['Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa', 'Lambda', 'Mu', 'Nu', 'Xi', 'Omicron', 'Pi', 'Rho', 'Sigma', 'Tau', 'Upsilon', 'Phi', 'Chi', 'Psi', 'Omega']

func GetStarName():
	var _name
	for i in range(starNames.size()):
		if usedStarNames.find(starNames[i]):
			usedStarNames.append(starNames[i])
			_name = starNames[i]
	return _name

func IntToRoman(_number : int):
	var _roman_numeral = ''
	for key in roman_numerals:
		while _number >= roman_numerals.get(key):
			_roman_numeral += key
			_number -= roman_numerals.get(key)
	return _roman_numeral

func IntToGreek(_number : int):
	# Adjust the number to fit within the range of Greek letters
	_number = (_number - 1) % 24
	return greek_letters[_number]
