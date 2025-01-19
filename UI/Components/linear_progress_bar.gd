extends Control

class_name LinearProgressBar

var _shader: ShaderMaterial

func _ready():
	_shader = CustomShaders.GetLinearProgressShader()
	$ColorRect.material = _shader

func set_percent(percent: float):
	var normalized = percent / 100
	_shader.set_shader_parameter("percent_complete", normalized)
