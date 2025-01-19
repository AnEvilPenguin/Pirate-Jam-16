extends Node2D

class_name Eye

@export
var flipHorizontal: bool

@export
var pupilSize: float = 15.0;

@onready
var _normal: Sprite2D = $NormalEye

@onready
var _strained: Sprite2D = $StrainedEye

var direction: Vector2 = Vector2(64,0)

var eyeStyle: int = 0

# center acording to shader is 0.5,0.5 regardless of godot positioning
var _center
var _resolution
var _material: ShaderMaterial

func _ready():
	var rect = _normal.get_rect()
	_resolution = rect.size
	_center = _resolution / 2
	
	_material = CustomShaders.GetEyeShader()
	_normal.material = _material
	
	_material.set_shader_parameter("resolution", _resolution)
	
	_strained.flip_h = flipHorizontal


func _process(_delta):
	_set_eye_style()
	
	var maxLength = _center.x - pupilSize
	
	var lookDirection = _center - direction.rotated(-global_rotation).limit_length(maxLength)
	_material.set_shader_parameter("pupil_position", lookDirection)
	
	var normalizedSize = pupilSize / _resolution.x
	_material.set_shader_parameter("pupil_size", normalizedSize)


func _set_eye_style():
	match eyeStyle:
		0:
			_normal.visible = true
			_strained.visible = false
		
		1:
			_normal.visible = false
			_strained.visible = true


# TODO smooth transition to new location e.g. set a timer and gradually move by a percentage until done
