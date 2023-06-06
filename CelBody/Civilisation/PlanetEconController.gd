extends Node3D
#This is where the central spaceport for the colony is.
#Times Thousand
var population 
@onready var planet = get_parent()
@onready var planetInventory = $Inventory
@onready var stockpiledInv = $SpacePort/Inventory

func _ready():
	#Needs running afterWorldgen. When Colony Creation is in
	name = str(planet.name," Base ",CoyUtils.IntToGreek(1))
func update():
	pass
