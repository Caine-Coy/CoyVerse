extends Control

@onready var nameLabel = $InfoBox/MarginContainer/VBoxContainer/ObjectName
@onready var typeLabel = $InfoBox/MarginContainer/VBoxContainer/ObjectType

var selectedObject
var currPlanet : CelestialBody
func _on_update_infobox(_object):
	selectedObject  = _object.get_parent()
	CoyDebug.Log(str(selectedObject.name," Requested Infobox Update"),CoyDebug.verbosityStates.ALL)
	nameLabel.text = selectedObject.name
	
	SetTypeBox(selectedObject)

func SetTypeBox(_object):
	if selectedObject.is_in_group("Planet") or selectedObject.is_in_group("Star"):
		currPlanet = selectedObject
		var _typeText
		if (selectedObject.is_in_group("Planet")):
			_typeText = currPlanet.GetPlanetTypeStr()
		else:
			_typeText = currPlanet.GetCelestialTypeStr()
		typeLabel.text = _typeText
