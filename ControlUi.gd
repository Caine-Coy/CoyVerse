extends Control

@onready var galacticController = get_tree().get_first_node_in_group("GalacticCore")

#InfoBox
@onready var nameLabel = %InfoBox/ObjectName
@onready var typeLabel = %InfoBox/ObjectType

#Cheat Menu
@onready var cheatMenu = %CheatMenu
@onready var addPopCheat = %ColonyCheats/AddPopButton
var cheatMode = false
#Inv Labels
@onready var popLabel = %ColonyLabel/PopLabel
var popLabelPrefix = "Pop: "
@onready var energyLabel = %ColonyLabel/EnergyLabel
var energyLabelPrefix = "Energy: "
@onready var bMatLabel = %ColonyLabel/BMatLabel
var bMatLabelPrefix = "Basic Mats: "
@onready var aMatLabel = %ColonyLabel/AMatLabel
var aMatLabelPrefix = "Advanced Mats: "
@onready var hydrogenLabel = %ColonyLabel/HydrogenLabel
var hydrogenLabelPrefix = "Hydrogen: "

#Main Panel
#Get Colony Specific UI. Disabled when on planet
@onready var colonyUI = get_tree().get_nodes_in_group("ColonyUI")
#
var selectedObject
var isColony = false
var currPlanet : CelestialBody
var currInv = null

#DateBox
@onready var dateLabel = $DateBox/MarginContainer/HBoxContainer3/HBoxContainer/DateLabel
enum DateModes {DMY,YMD,MDY}
var dateMode = DateModes.DMY
signal play_button_pressed
signal pause_button_pressed

func _input(event):
	if Input.is_action_just_released("cheat_key"):
		cheatMode = !cheatMode
		cheatMenu.visible = cheatMode

func _on_update_infobox(_object):
	selectedObject  = _object.get_parent()
	CoyDebug.Log(str(selectedObject.name," Requested Infobox Update"),CoyDebug.verbosityStates.ALL)
	UpdateUI()

func UpdateUI():
	nameLabel.text = selectedObject.name
	SetTypeBox(selectedObject)
	DisplayInventory(selectedObject)
	ColonyMode()

func ColonyMode():
	addPopCheat.disabled = not isColony

func DisplayInventory(_object):
	var colonyInv = selectedObject.get_node_or_null("Inventory")
	print(_object)
	print(colonyInv)
	if colonyInv != null:
		var itemInventory : Dictionary = colonyInv.GetStored()
		currInv = colonyInv
		popLabel.text = str(popLabelPrefix, itemInventory.get("Pop"))
		energyLabel.text = str(energyLabelPrefix,itemInventory.get("Energy"))
		bMatLabel.text = str(bMatLabelPrefix,itemInventory.get("BMats"))
		aMatLabel.text = str(aMatLabelPrefix,itemInventory.get("AMats"))
		hydrogenLabel.text = str(hydrogenLabelPrefix, itemInventory.get("Hydrogen"))
	else:
		currInv = null
		popLabel.text = str(popLabelPrefix ,"None")
		energyLabel.text = str(popLabelPrefix ,"None")
		bMatLabel.text = str(popLabelPrefix ,"None")
		aMatLabel.text = str(popLabelPrefix ,"None")
		hydrogenLabel.text = str(popLabelPrefix ,"None")

func SetTypeBox(_object):
	if selectedObject.is_in_group("Planet") or selectedObject.is_in_group("Star"):
		currPlanet = selectedObject
		var _typeText
		if (selectedObject.is_in_group("Planet")):
			_typeText = currPlanet.GetPlanetTypeStr()
		else:
			_typeText = currPlanet.GetCelestialTypeStr()
		typeLabel.text = _typeText
		isColony = false
		
	elif selectedObject.is_in_group("Colony"):
		currPlanet = selectedObject.get_parent()
		typeLabel.text = "Colony"
		isColony = true

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

func _on_add_pop_button_button_up():
	if currInv != null:
		currInv.AddPop(10000)
	UpdateUI()
