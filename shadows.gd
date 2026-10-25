extends Polygon2D

# 25/10/26

func _ready() -> void:
	if Global.SHADOWS == false:
		queue_free()
