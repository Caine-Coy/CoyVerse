extends Node3D
class_name CelestialBody

@onready var bodySurface : CSGSphere3D = %Body
@onready var collisionSurface : CollisionShape3D = %ClickableArea/Collider
@onready var barycentre : Node3D = get_parent()
@onready var system : Node3D #

enum bodyType{STAR,PLANET,MOON,ASTEROID}
var radius
var rotationSpeed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	barycentre.name = name
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Orbit(delta)

func SetRadius(iRadius):
	radius = iRadius
	bodySurface.radius = iRadius
	collisionSurface.shape.set_radius(25)

func Orbit(delta):
	barycentre.rotate(Vector3(0,1,0),rotationSpeed*delta)


