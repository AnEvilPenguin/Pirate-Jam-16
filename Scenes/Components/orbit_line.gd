extends Node

class_name OrbitLine

@onready
var line: Line2D = $Line2D

@export
var distance: float

@export
var pointCount: float = 360

@export
var centerPoint: Vector2 = Vector2.ZERO

var _lastDistance: float


# TODO get target, just parent?
# TODO put target name just above line
# TODO color line
# TODO put distance on line
# TODO get pluto position
# TODO put name at same relative angle to pluto

func _process(_delta):
	if (_lastDistance != distance):
		_draw_circle_at_point(centerPoint, distance, pointCount)
		_lastDistance = distance

func _draw_circle_at_point(center, radius, points):
	line.clear_points()
	
	var first
	
	for i in range(points):
		var angle = (i / points) * TAU
		
		var x = center.x + radius * cos(angle)
		var y = center.y + radius * sin(angle)
		
		var vec = Vector2(x, y)
		
		if (i == 0):
			first = vec
		
		line.add_point(vec)
		pass
	
	line.add_point(first)
