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

@export
var minWidth = 2.0

@export
var maxWidth = 60.0
@export
var widthFactor= 1.5

var _lastDistance: float


# TODO get target, just parent?
# TODO put target name just above line
# TODO color line
# TODO put distance on line
# TODO get pluto position
# TODO put name at same relative angle to pluto

func _unhandled_input(_event):
	if (Input.is_action_just_pressed("zoom_in")):
		_set_width(-widthFactor)
	
	if (Input.is_action_just_pressed("zoom_out")):
		_set_width(+widthFactor)

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

func _set_width(value: float):
	# FIXME link this more closely to camera zoom. This sucks at the moment
	var width = clamp(line.width + value, minWidth, maxWidth)
	
	var tween = get_tree().create_tween()
	tween.tween_property(line, "width", width, 0.1).set_ease(Tween.EASE_IN_OUT)
