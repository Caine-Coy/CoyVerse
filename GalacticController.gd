extends Node3D

var SolarScene : PackedScene = load("res://CelBody/solarSystem.tscn")
#Godot Meters to AU
const SCALE = 100
const systemCount = 1
#Star System Planet Amounts
const starCountMin = 1
const starCountMax = 1
const planetCountMin = 4
const planetCountMax = 4

signal galaxy_finished_loading
# Called when the node enters the scene tree for the first time.
func _ready():
	for systemNum in range(systemCount):
		makeSystem(str(systemNum),randi_range(starCountMin,starCountMax),randi_range(planetCountMin,planetCountMax))
	galaxy_finished_loading.emit()

func makeSystem(_name:String,_starCount:int,_planetCount:int):	
	var system : Node3D = SolarScene.instantiate()
	system.planetCount = _planetCount
	system.starCount = _starCount
	system.name = CoyName.GetStarName()
	add_child(system)
	
	system.rotationSpeed = float(randi() % 100) / 100
	
	CoyDebug.Log(str("System ",_name," created with ",_starCount," stars and ",_planetCount," planets"),CoyDebug.verbosityStates.ALL)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
