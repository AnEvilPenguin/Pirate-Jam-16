extends Camera2D

@export
var zoomFactor = 0.1

@export
var zoomDuration = 0.2

@export
var minZoom = 0.1

@export
var maxZoom = 1.5


func _unhandled_input(event):
	if (Input.is_action_just_pressed("zoom_in")):
		_set_zoom(zoomFactor)
	
	if (Input.is_action_just_pressed("zoom_out")):
		_set_zoom(-zoomFactor)
	
func _set_zoom(value: float):
	# x and y should be identical
	var currentZoom = zoom.x
	var zoomToBe = clamp(currentZoom + value, minZoom, maxZoom)
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(zoomToBe, zoomToBe), zoomDuration).set_ease(Tween.EASE_IN_OUT)
