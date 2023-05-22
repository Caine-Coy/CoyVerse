extends Node3D
#GalacticCore
@onready var galaxyController : Node = get_tree().get_nodes_in_group("GalacticCore")[0]
#Scenes
var starScene : PackedScene = load("res://CelBody/Planet/star.tscn")
var planetScene : PackedScene = load("res://CelBody/Planet/planet.tscn")

var starCount
var rotationSpeed = 1
var planetCount
var starRadius = 25

var star : Node3D
var planets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if starCount == 1:
		makeStar(starRadius)
	for i in range(planetCount):
		makePlanet(i)

func makeStar(radius):
	star = starScene.instantiate()
	add_child(star)
	star = star.get_child(0)
	star.SetRadius(radius)

func makePlanet(planetNum):
	var planetBary : Node3D = planetScene.instantiate()
	var planet = planetBary.get_child(0)

	planet.add_to_group(name)
	planets.append(planet)
	star.add_child(planetBary)
	
	planetBary.name = str(name," ",CoyName.IntToRoman(planetNum+1))
	planet.position.z = -((galaxyController.SCALE * planetNum) + (starRadius*4))
	
	planet.SetRadius(10)
	planet.rotationSpeed = 0.01*planetNum
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Orbit(delta)
	pass

func Orbit(delta):
	#rotate(Vector3(0,1,0),rotationSpeed*delta)
	pass

func getStar():
	return star
