extends Node2D

class_name Eye

@export
var pupilSize: float = 10.0;

@onready
var _sprite: Sprite2D = $Sprite2D

var direction: Vector2 = Vector2(64,0)

# center acording to shader is 0.5,0.5 regardless of godot positioning
var _center
var _resolution
var _material: ShaderMaterial


func _ready():
	var rect = _sprite.get_rect()
	_resolution = rect.size
	_center = _resolution / 2
	
	_material = CustomShaders.GetEyeShader()
	_sprite.material = _material
	
	_material.set_shader_parameter("resolution", _resolution)


func _process(delta):
	var maxLength = _center.x - pupilSize
	
	# TODO deal with global rotation?
	var lookDirection = _center - direction.limit_length(maxLength)
	var normalizedSize = pupilSize / _resolution.x
	
	_material.set_shader_parameter("pupil_position", lookDirection)
	_material.set_shader_parameter("pupil_size", normalizedSize)


# TODO smooth transition to new location e.g. set a timer and gradually move by a percentage until done
