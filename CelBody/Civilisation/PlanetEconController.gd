extends Node3D
#This is where the central spaceport for the colony is.
#Times Thousand
var population 
@onready var planet = get_parent()
@onready var planetInventory = $PlanetInventory
@onready var stockpiledInv = $SpacePort/Inventory

func _ready():
	name = str(planet.name," Base ",CoyName.IntToGreek(1))
func update():
	pass
