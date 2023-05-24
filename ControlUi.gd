extends Control

@onready var nameLabel = $InfoBox/ObjectName

func _on_update_infobox(object):
	object = object.get_parent()
	CoyDebug.Log(str(object.name," Requested Infobox Update"),CoyDebug.verbosityStates.ALL)
	nameLabel.text = object.name
