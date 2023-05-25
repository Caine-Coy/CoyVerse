extends Node3D

@export_range(0,1) var camSpeedDivisor = 0.4
@export_range(0,1) var camRotDivisor = 0.025
@export_range(0,1) var camSpeedZoomMult = 0.05
@export_range(0,1) var camZoomMult = 0.1
@export var camZoomMax = 5000
@export var camZoomMin = 0.1

@onready var camera : Camera3D = $"CamRotateNode/Camera3D"
@onready var camRotateNode : Node3D = $"CamRotateNode"
@onready var galacticCore : Node3D = $".."

var focusViewPreset : Vector3 = Vector3(0,0,0)

var zoomLevel
var currSelectedObject : Node3D
var currObjectChanged
var colonyMode = false

signal update_infobox(object : Node3D)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movement(delta)
	_uiKeys()

func _uiKeys():
	if Input.is_action_just_released("ui_click"):
			#Move Camera to selected object parent
		if currSelectedObject!=null && currObjectChanged:
			update_infobox.emit(currSelectedObject)
			currObjectChanged = false
			if currSelectedObject != get_parent_node_3d() && colonyMode == false:
				FollowObject(currSelectedObject)
				if currSelectedObject.is_in_group("Colony"):
					CoyDebug.Log(str("Entered colony mode around ",currSelectedObject.get_parent()),CoyDebug.verbosityStates.ALL)
					colonyMode = true
			
	
	if Input.is_action_pressed("deselect"):
		if currSelectedObject != null && get_parent_node_3d() != galacticCore:
			DetachView()
		if colonyMode:
			colonyMode = false

func _movement(delta):
	var hor_dir = Input.get_vector("move_left","move_right","move_forward","move_backward")
	var rot_dir = Input.get_axis("rotate_left","rotate_right")
	var tilt_dir = Input.get_axis("tilt_up","tilt_down")
	translate(Vector3(hor_dir.x,0,(hor_dir.y)*camSpeedDivisor)*(camera.position.z*camSpeedZoomMult))
	rotate(Vector3(0,1,0),rot_dir*camRotDivisor)
	if (camRotateNode.rotation.x <= 1.5 && tilt_dir > 0):
		camRotateNode.rotate(Vector3(1,0,0),tilt_dir*camRotDivisor)
	if (camRotateNode.rotation.x >= -1 && tilt_dir < 0):
		camRotateNode.rotate(Vector3(1,0,0),tilt_dir*camRotDivisor)

func _input(event):
	#Zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP && camera.position.z > camZoomMin:
			camera.translate_object_local(Vector3(0,0,-1)*camera.position.z*camZoomMult)
			zoomLevel = int(camera.position.z)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN && camera.position.z < camZoomMax:
			camera.translate_object_local(Vector3(0,0,1)*camera.position.z*camZoomMult)
			zoomLevel = int(camera.position.z)

func object_brushed(object):
	currSelectedObject = object
	currObjectChanged = true
	
func DetachView():
	var _pos = global_position
	var _rot = global_rotation
	FollowObject(galacticCore)
	global_rotation = _rot
	global_position = _pos
	
func FollowObject(object):
	get_parent_node_3d().remove_child(get_node("."))
	object.add_child(get_node("."))
	position = focusViewPreset
	CoyDebug.Log(str("Following Object ", object.name),CoyDebug.verbosityStates.ALL)

func ScanClickables():
	var clickables = get_tree().get_nodes_in_group("Clickable")
	for i in range(clickables.size()):
		if !clickables[i].object_brushed.is_connected(object_brushed):
			clickables[i].object_brushed.connect(object_brushed)

func _on_galactic_core_galaxy_finished_loading():
	ScanClickables()
