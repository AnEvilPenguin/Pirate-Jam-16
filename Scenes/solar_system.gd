extends Node2D

class_name SolarSystem

var planets: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for planet in $Planets.get_children():
		planets[planet.name] = planet
	
	Global.solarSystem = self
