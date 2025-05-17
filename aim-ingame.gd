extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()

func _ready() -> void:
	texture = Global.CURRENT_AIM
