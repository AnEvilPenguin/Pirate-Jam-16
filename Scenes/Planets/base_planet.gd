@tool
extends CharacterBody2D

class_name BasePlanet

@export
var speed = 300.0

@export
var mass: float = 59.722

@export
var center: Node2D

@export
var texture: Texture2D

@export
var textureScale: Vector2 = Vector2(0.1, 0.1)

@export
var orbitalDistance: float

@onready
var _orbitLine: OrbitLine = $OrbitLine

var _centerPosition: Vector2

var _destroyed = false

func _ready():
	if (texture):
		$Sprite2D.texture = texture
		$Sprite2D.scale = textureScale
	
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance
	
	if (center == null):
		_centerPosition = Vector2.ZERO
	else:
		_centerPosition = center.global_position
		_orbitLine.centerPoint = _centerPosition

func _process(_delta):
	if(Engine.is_editor_hint() && texture):
		$Sprite2D.texture = texture
		$Sprite2D.scale = textureScale
		return
	elif (Engine.is_editor_hint()):
		return
	
	if (_destroyed):
		queue_free()
		return
	
	if (center):
		_centerPosition = center.global_position
		_orbitLine.centerPoint = _centerPosition
	
	var player = Global.gameController.player
	
	var my_mass = mass
	var their_mass = player.mass
	
	var hitPercent = their_mass / (my_mass * 2) * 100
	
	# hue 0 - 120 (red - to green)
	var hue = hitPercent * 1.2
	var clamped = clamp(hue, 0.0, 120.0)
	
	# Set line color based on whether player can successfully hit or not
	var newColor = Color.from_hsv(clamped / 360.0, 1.0, 1.0)
	
	_orbitLine.color = newColor

func _physics_process(_delta):
	if(Engine.is_editor_hint()):
		return
	
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	# move_and_slide uses delta automaticslly
	move_and_slide()


func Destroy():
	for child in get_children():
		if(child.get_class() == 'CharacterBody2D'):
			child.reparent(get_parent())

			child.SetCenter(center)
	
	visible = false
	_destroyed = true


func SetCenter(Center: Node2D):
	center = Center
	
	orbitalDistance = (global_position - center.global_position).length()
	
	_orbitLine.centerPoint = center.global_position
	_orbitLine.distance = orbitalDistance
