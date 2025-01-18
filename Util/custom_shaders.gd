@tool
extends Node

class_name CustomShaders

static var _simpleColorShader: Resource = load("res://Util/Shaders/simple_color.gdshader")
static var _eyeShader: Resource = load("res://Util/Shaders/eye.gdshader")

static func GetSimpleColorShader() -> ShaderMaterial:
	return _get_generic_shader(_simpleColorShader)

static func GetEyeShader() -> ShaderMaterial:
	return _get_generic_shader(_eyeShader)

static func _get_generic_shader(res: Resource) -> ShaderMaterial:
	var shader: Resource = res.duplicate(true)
	
	var material :ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	
	return material
