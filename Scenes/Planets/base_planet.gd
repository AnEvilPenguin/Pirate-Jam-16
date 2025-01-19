extends CharacterBody2D

@export
var speed = 300.0

@export
var mass: float = 59.722

@export
var center: Node2D

@export
var texture: Texture2D

@export
var orbitalDistance: float

@onready
var _orbitLine: OrbitLine = $OrbitLine

var _centerPosition: Vector2

func _ready():
	$Sprite2D.texture = texture
	
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance
	
	if (center == null):
		_centerPosition = Vector2.ZERO
	else:
		_centerPosition = center.global_position

func _process(_delta):
	if (center):
		_centerPosition = center.global_position
	
	var player = Global.gameController.player
	
	var my_mass_x_speed = mass * speed
	var their_mass_x_speed = player.mass * abs(player.speed)
	
	# TODO set line hue based on whether player can hit successfully or not
	
	var hitPercent = their_mass_x_speed / my_mass_x_speed * 100
	
	# hue 0 - 120 (red - to green)
	var hue = hitPercent * 1.2
	var clamped = clamp(hue, 0.0, 120.0)
	
		
	var newColor = Color.from_hsv(clamped / 360.0, 1.0, 1.0)
	
	_orbitLine.color = newColor

func _physics_process(_delta):
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	# move_and_slide uses delta automaticslly
	move_and_slide()
