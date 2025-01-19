extends CharacterBody2D

@export
var speed = 250.0

@export
var mass: float = 13

@export
var massCost = 0.1

# Consider changing acceleration with some control? up/down w/s possibly mouse wheel?
@export
var acceleration: float = 30.0

# FIXME use this as an input for a logarithmic scale
@export
var orbitalDistance: float

@export
var targetObject: Node2D

@onready
var _orbitLine: OrbitLine = %OrbitLine

@onready
var _massEjection: GPUParticles2D = %MassEmitter

var _gameController: GameController

var _centerPosition = Vector2.ZERO

func _ready():
	if (orbitalDistance < 1.0):
		orbitalDistance = global_position.x
	
	_orbitLine.distance = orbitalDistance
	
	_gameController = Global.gameController
	
	_gameController.playerInfoPanel.SetDistance(orbitalDistance)
	_gameController.playerInfoPanel.SetSpeed(speed)
	_gameController.playerInfoPanel.SetMass(mass)

func _process(delta):
	_process_mouse_rotation()
	_set_player_movement(delta)
	
	if (is_instance_valid(targetObject)):
		var dirToTarget = global_position - targetObject.global_position;
		%Eye1.direction = dirToTarget
		%Eye2.direction = dirToTarget

func _physics_process(_delta):
	if (mass <= 0):
		printerr("Game Over!")
	
	var dirToCenter = global_position - _centerPosition
	
	velocity = dirToCenter.orthogonal().limit_length(speed);
	
	var offset = orbitalDistance - dirToCenter.length()
	velocity += dirToCenter.limit_length() * offset
	
	move_and_slide()
	
	_orbitLine.distance = orbitalDistance

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
	
	var projecileSpeed = max(20, abs(speed))
	
	# Update the particle velocity based on current speed
	# The alternative is to use local coordinates, but this looks rubbish
	particleMaterial.set_param_min(ParticleProcessMaterial.Parameter.PARAM_INITIAL_LINEAR_VELOCITY, -projecileSpeed)
	particleMaterial.set_param_max(ParticleProcessMaterial.Parameter.PARAM_INITIAL_LINEAR_VELOCITY, -(projecileSpeed * 0.6))
	
	var dirToCenter = (global_position - _centerPosition).limit_length()
	var orbitalDir = dirToCenter.orthogonal().limit_length()
	
	# rotate so forward in same direction as player
	var forward = Vector2.UP.rotated(rotation)
	
	# TODO jettison mass in line with rate of acceleration somehow
	# TODO display key stats in UI
	# TODO game over when mass lower than critical level
	
	var toCenter = dirToCenter.dot(forward)
	orbitalDistance += (toCenter * acceleration) * delta
	_gameController.playerInfoPanel.SetDistance(orbitalDistance)
	
	var inOrbit = orbitalDir.dot(forward)
	speed += (inOrbit * acceleration) * delta
	_gameController.playerInfoPanel.SetSpeed(speed)
	
	mass -= massCost * delta
	_gameController.playerInfoPanel.SetMass(mass)


func _process_mouse_rotation():
	var mouseCoords = get_global_mouse_position()
	var mouseDirection = mouseCoords - global_position;
	
	rotation = mouseDirection.angle() + (PI / 2.0)


func _on_area_2d_body_entered(body: Node2D):
	if (body.get_instance_id() == get_instance_id()):
		return
	
	var my_mass_x_speed = mass * abs(speed)
	var their_mass_x_speed = body.mass * body.speed
	
	print("collision with: " + body.name)
	print("me: " + str(my_mass_x_speed))
	print("them: " + str(their_mass_x_speed))
	
	if (my_mass_x_speed > their_mass_x_speed):
		# TODO some sort of animation or effect or whatever?
		body.visible = false
		body.queue_free()
		mass += 2 * body.mass
	else:
		printerr("Game Over!")
