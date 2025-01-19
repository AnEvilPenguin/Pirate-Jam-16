extends Control

class_name PlayerInformationPanel

var _targetValue
var _score: float = 0

func SetMass(value: float):
	if (!_targetValue && Global.solarSystem):
		var earth = Global.solarSystem.planets.get("Earth")
		_targetValue = earth.mass * earth.speed
	
	%MassContainer/Value.text = str(round_to_dec(value, 0))
	
	#var percentNormal = value / _targetValue
	#%MassContainer/LinearProgressBar.set_percent(min(percentNormal, 1.0))

func SetDistance(value: float):
	%OrbitContainer/Value.text = str(round_to_dec(value, 0))

func SetSpeed(value: float):
	%SpeedContainer/Value.text = str(round_to_dec(value, 0))	

func AddScore(value:float):
	%ScoreContainer/Value.text = str(round_to_dec(value, 0))	

func round_to_dec(value: float, digit: int):
	return round(value * pow(10.0, digit)) / pow(10.0, digit)
