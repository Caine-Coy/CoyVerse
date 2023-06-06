extends Node3D
class_name CelestialBody

@onready var bodySurface : CSGSphere3D = %Body
@onready var collisionSurface : CollisionShape3D = %ClickableArea/Collider
@onready var barycentre : Node3D = get_parent()
@onready var system : Node3D #
@onready var galacticController = get_tree().get_first_node_in_group("GalacticCore")

enum CelestialTypes{STAR,PLANET,MOON,ASTEROID}
enum PlanetTypes{CONTINENTAL,WATER_OCEAN,ICE,MAGMA,BARREN}

@export var celestialType : CelestialTypes
var planetType
var radius
var orbitalSpeed
var distanceFromStar
var orbitalPeriod
# Called when the node enters the scene tree for the first time.
func _ready():
	barycentre.name = name
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Orbit(delta)

##NONWORKING
func SetRadius(_radius):
	radius = _radius
	bodySurface.radius = _radius
	collisionSurface.shape.set_radius(_radius)

#Need to Calculate Rotation Speed
func Orbit(delta):
	if (not galacticController.paused):
		barycentre.rotate(Vector3(0,1,0),(orbitalSpeed)*(delta*galacticController.speeds[-galacticController.speed]))

func SetRandomPlanetType():
	if celestialType == CelestialTypes.PLANET or celestialType == CelestialTypes.MOON:
		planetType = PlanetTypes.keys()[randi_range(0,PlanetTypes.size()-1)]
	else:
		CoyDebug.Error(str("Tried to set planet type of non planet ",name))

func GetCelestialType():
	return CelestialTypes.keys()[celestialType]

func GetCelestialTypeStr():
	return GetCelestialType().capitalize()

func GetPlanetTypeStr():
	return planetType.capitalize()

func SpawnColony(_location):
	pass
