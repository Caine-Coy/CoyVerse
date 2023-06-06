extends Node3D
#GalacticCore
@onready var galaxyController : Node3D = get_tree().get_nodes_in_group("GalacticCore")[0]
#Scenes
var starScene : PackedScene = load("res://CelBody/PrefabScenes/star.tscn")
var planetScene : PackedScene = load("res://CelBody/PrefabScenes/planet.tscn")

var starCount
var rotationSpeed = 1
var planetCount
var starRadius = 25

var star : CelestialBody
var planets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if starCount == 1:
		makeStar(starRadius)
	for i in range(planetCount):
		makePlanet(i)

func makeStar(radius):
	var starRoot = starScene.instantiate()
	starRoot.add_to_group(name)
	
	add_child(starRoot)
	star = starRoot.get_child(0)
	star.orbitalSpeed = 0
	star.add_to_group("Star")
	star.name = name

func makePlanet(planetNum):
	var planetBary : Node3D = planetScene.instantiate()
	var planet = planetBary.get_child(0)

	planet.add_to_group(name)
	planet.add_to_group("Planet")
	planets.append(planet)
	
	planet.SetRandomPlanetType()
	planet.distanceFromStar = (galaxyController.SCALE * planetNum) + (starRadius*4)
	planet.orbitalPeriod = planetNum+1 * 121
	planet.orbitalSpeed = planet.orbitalPeriod/(planetNum+1) / 100.0
	
	star.add_child(planetBary)
	
	planetBary.name = str(name," ",CoyUtils.IntToRoman(planetNum+1))
	planet.name = str(name," ",CoyUtils.IntToRoman(planetNum+1))
	
	planet.position.z = -(planet.distanceFromStar)
	CoyDebug.Log(str("Made new planet ",planet.name," of type ", planet.planetType),CoyDebug.verbosityStates.ALL)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not galaxyController.paused:
		Orbit(delta)
	pass

func Orbit(delta):
	#rotate(Vector3(0,1,0),rotationSpeed*delta)
	pass

func getStar():
	return star
