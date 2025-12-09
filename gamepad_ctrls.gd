extends Node

var SPEED = 10
var CONTROLLER_CONNECTED = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CONTROLLER_CONNECTED:
		var move_speed = SPEED * Global.GAYPAD_AIDS
		if Input.is_action_pressed("mouseup"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0, -move_speed))
		if Input.is_action_pressed("mousedown"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0, move_speed))
		if Input.is_action_pressed("mouseleft"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(-move_speed, 0))
		if Input.is_action_pressed("mouseright"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(move_speed, 0))

func _ready() -> void:
	var gaypads = Input.get_connected_joypads()
	if gaypads.size() != 0:
		print("Гей(м)пад подключен: ", gaypads)
		CONTROLLER_CONNECTED = true
	else:
		print("Гейпадов нет:(")
