extends CharacterBody2D

@export
var speed = 250.0

# Consider changing acceleration with some control? up/down w/s possibly mouse wheel?
@export
var acceleration: float = 2.0

@export
var orbitalDistance: float

@export
var targetObject: Node2D

@onready
var _orbitLine: OrbitLine = %OrbitLine

@onready
var _massEjection: GPUParticles2D = %MassEmitter

var _centerPosition = Vector2.ZERO

func _ready():
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance

func _process(delta):
	_process_mouse_rotation()
	_set_player_movement(delta)
	
	if (targetObject):
		var dirToTarget = global_position - targetObject.global_position;
		%Eye1.direction = dirToTarget
		%Eye2.direction = dirToTarget

func _physics_process(_delta):
	_orbitLine.distance = orbitalDistance
	
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	%Label.text = "center: " + str(dirToCenter.length())
	%Label2.text = "speed: " + str(speed)
	
	move_and_slide()

func _set_player_movement(delta):
	if (!Input.is_action_pressed("add_momentum")):
		_massEjection.emitting = false
		%Eye1.eyeStyle = 0
		%Eye2.eyeStyle = 0
		return
	
	%Eye1.eyeStyle = 1
	%Eye2.eyeStyle = 1
	
	_massEjection.emitting = true
	var particleMaterial: ParticleProcessMaterial = _massEjection.process_material;
	
	# Update the particle velocity based on current speed
	# The alternative is to use local coordinates, but this looks rubbish
	particleMaterial.set_param_min(ParticleProcessMaterial.Parameter.PARAM_INITIAL_LINEAR_VELOCITY, -speed)
	particleMaterial.set_param_max(ParticleProcessMaterial.Parameter.PARAM_INITIAL_LINEAR_VELOCITY, -(speed * 0.6))
	
	var dirToCenter = (global_position - _centerPosition).limit_length()
	var orbitalDir = dirToCenter.orthogonal().limit_length()
	
	# rotate so forward in same direction as player
	var forward = Vector2.UP.rotated(rotation)
	
	var toCenter = dirToCenter.dot(forward)
	orbitalDistance += (toCenter * acceleration) * delta
	
	var inOrbit = orbitalDir.dot(forward)
	speed += (inOrbit * acceleration) * delta


func _process_mouse_rotation():
	var mouseCoords = get_global_mouse_position()
	var mouseDirection = mouseCoords - global_position;
	
	rotation = mouseDirection.angle() + (PI / 2.0)
