@tool
extends Node

class_name CustomShaders

static var _simpleColorShader: Resource = load("res://Util/Shaders/simple_color.gdshader")

static func GetSimpleColorShader() -> ShaderMaterial:
	print("loading")
	var shader: Resource = _simpleColorShader.duplicate(true)
	
	var material :ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	
	return material
