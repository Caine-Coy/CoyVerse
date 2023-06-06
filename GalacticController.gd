extends Node3D

var SolarScene : PackedScene = load("res://CelBody/solarSystem.tscn")
#Godot Meters to AU
#so 100M is 1 AU
const SCALE = 100
const systemCount = 1
#Star System Planet Amounts
const starCountMin = 1
const starCountMax = 1
const planetCountMin = 4
const planetCountMax = 4

signal galaxy_finished_loading
signal dayPassed

#Frames(ish) per day
var speeds = [1,0.25,0.01]
var speed = 1
var timePerDay
var _deltaTime = 0

var paused = true
var day = 1
var month = 1
var year = 2100
var date

# Called when the node enters the scene tree for the first time.
func _ready():
	for systemNum in range(systemCount):
		makeSystem(str(systemNum),randi_range(starCountMin,starCountMax),randi_range(planetCountMin,planetCountMax))
	galaxy_finished_loading.emit()

func makeSystem(_name:String,_starCount:int,_planetCount:int):	
	var system : Node3D = SolarScene.instantiate()
	system.planetCount = _planetCount
	system.starCount = _starCount
	system.name = CoyUtils.GetStarName()
	add_child(system)
	
	
	
	CoyDebug.Log(str("System ",_name," created with ",_starCount," stars and ",_planetCount," planets"),CoyDebug.verbosityStates.ALL)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not paused:
		_deltaTime += delta
		if (_deltaTime >= timePerDay):
			ProgressToNextDay()
			_deltaTime = 0

func ProgressToNextDay():
	if day == 30:
		if month == 12:
			month = 1
			year += 1
		else:
			month += 1
		day = 1
	else:
		day += 1
	
	date = [day,month,year]
	dayPassed.emit(date)

func _on_pause_button_pressed():
	paused = true
	CoyDebug.Log("Game Paused",CoyDebug.verbosityStates.INTERESTING_EVENTS)

#Called by all speed buttons
func _on_play_button_pressed(_speed):
	speed = _speed
	timePerDay = speeds[speed-1]
	if (paused):
		paused = false
		CoyDebug.Log(str("Game Unpaused at Speed ",speed),CoyDebug.verbosityStates.INTERESTING_EVENTS)
	
