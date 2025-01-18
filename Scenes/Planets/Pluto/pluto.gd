extends CharacterBody2D

@export
var speed = 250.0

@export
var orbitalAcceleration: float = 2.0

@export
var acceleration: float = 2.0

@export
var orbitalDistance: float

@export
var targetObject: Node2D

@onready
var _orbitLine: OrbitLine = $OrbitLine

var _centerPosition = Vector2.ZERO

func _ready():
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance

func _process(delta):
	_set_player_movement(delta)
	
	if (targetObject):
		var dirToTarget = global_position - targetObject.global_position;
		$Sprite2D/Eye1.direction = dirToTarget

func _physics_process(_delta):
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	$Label.text = "center: " + str(dirToCenter.length())
	$Label2.text = "speed: " + str(speed)
	
	move_and_slide()

func _set_player_movement(delta):
	var change = Input.get_axis("ui_down", "ui_up")
	orbitalDistance += (change * orbitalAcceleration) * delta
	_orbitLine.distance = orbitalDistance
	
	var speedChange = Input.get_axis("ui_left", "ui_right")
	speed += (speedChange * acceleration) * delta
