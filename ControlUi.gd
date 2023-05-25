extends Control

#Spaghetti Causing
@onready var galacticController = get_parent().get_node("GalacticCore")
#InfoBox
@onready var nameLabel = $InfoBox/MarginContainer/VBoxContainer/ObjectName
@onready var typeLabel = $InfoBox/MarginContainer/VBoxContainer/ObjectType
var selectedObject
var currPlanet : CelestialBody
#DateBox
@onready var dateLabel = $DateBox/MarginContainer/HBoxContainer3/HBoxContainer/DateLabel
enum DateModes {DMY,YMD,MDY}
var dateMode = DateModes.DMY
signal play_button_pressed
signal pause_button_pressed

func _on_update_infobox(_object):
	selectedObject  = _object.get_parent()
	CoyDebug.Log(str(selectedObject.name," Requested Infobox Update"),CoyDebug.verbosityStates.ALL)
	nameLabel.text = selectedObject.name
	SetTypeBox(selectedObject)
	#~Get if colony
	#if selectedObject.get_node

func SetTypeBox(_object):
	if selectedObject.is_in_group("Planet") or selectedObject.is_in_group("Star"):
		currPlanet = selectedObject
		var _typeText
		if (selectedObject.is_in_group("Planet")):
			_typeText = currPlanet.GetPlanetTypeStr()
		else:
			_typeText = currPlanet.GetCelestialTypeStr()
		typeLabel.text = _typeText

func dateToStr(_date):
	return str(_date[0],"/",_date[1],"/",_date[2])

func formatDate(day,month,year):
	if dateMode == DateModes.DMY:
		return [day,month,year]
	if dateMode == DateModes.YMD:
		return [year,month,day]
	if dateMode == DateModes.MDY:
		return [month,day,year]
		
func _on_day_passed(_date):
	dateLabel.text = dateToStr(formatDate(_date[0],_date[1],_date[2]))

func _on_pause_button_button_up():
	pause_button_pressed.emit()
	
func _on_play_button_button_up():
	play_button_pressed.emit(1)

func _on_faster_speed_button_button_up():
	play_button_pressed.emit(2)

func _on_fastest_speed_button_button_up():
	play_button_pressed.emit(3)
