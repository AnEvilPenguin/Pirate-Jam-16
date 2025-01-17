@tool
extends CenterContainer

class_name IconButton

signal pressed

@export
var Disabled: bool = false

@export
var _iconTexture: Texture2D

@export
var _iconColor: Color = Color(0.8, 0.8, 0.8)

@onready
var _textureButton = $TextureButton

@onready
var _material: ShaderMaterial = CustomShaders.GetSimpleColorShader();


func _ready():
	_textureButton.material = _material
	_updateShader()


func _process(delta):
	if (Engine.is_editor_hint()):
		_updateShader()


func SetColor(color: Color):
	_iconColor = color
	_setShaderColor()


func _updateShader():
	if (!_iconTexture):
		return
	
	_textureButton.texture_normal = _iconTexture
	_setShaderColor()


func _setShaderColor():
	_material.set("shader_parameter/color1", _iconColor)


func _on_texture_button_pressed():
	if (!Disabled):
		pressed.emit()
