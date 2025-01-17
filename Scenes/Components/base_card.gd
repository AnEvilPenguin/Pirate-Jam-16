extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_scaleTexture($Border)
	_scaleTexture($Card)


func _scaleTexture(sprite: Sprite2D) -> void:
	sprite.scale *= size/sprite.texture.get_size()
