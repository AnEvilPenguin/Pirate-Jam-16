extends CharacterBody2D

@export
var speed = 250.0

@export
var orbitalAcceleration: float = 2.0

@export
var orbitalDistance: float

@onready
var _orbitLine: OrbitLine = $OrbitLine

var _centerPosition = Vector2.ZERO

func _ready():
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance

func _process(delta):
	var dirToCenter = global_position - _centerPosition
	_set_player_movement(delta)

func _physics_process(_delta):
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	$Label.text = "center: " + str(dirToCenter.length())
	
	move_and_slide()

func _set_player_movement(delta):
	var change = Input.get_axis("ui_down", "ui_up")
	orbitalDistance += (change * orbitalAcceleration) * delta
	_orbitLine.distance = orbitalDistance
	
