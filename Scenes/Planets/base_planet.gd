extends CharacterBody2D

@export
var speed = 300.0

@export
var center: Node2D

@export
var texture: Texture2D

@export
var orbitalDistance: float

var _centerPosition: Vector2

func _ready():
	$Sprite2D.texture = texture
	
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	if (center == null):
		_centerPosition = Vector2.ZERO
	else:
		_centerPosition = center.global_position

func _process(_delta):
	if (center):
		_centerPosition = center.global_position


func _physics_process(_delta):
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	# move_and_slide uses delta automaticslly
	move_and_slide()
