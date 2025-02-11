extends Node

var SPEED = 10
var CONTROLLER_CONNECTED = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CONTROLLER_CONNECTED:
		if Input.is_action_pressed("mouseup"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0,-SPEED))
		if Input.is_action_pressed("mousedown"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(0,SPEED))
		if Input.is_action_pressed("mouseleft"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(-SPEED,0))
		if Input.is_action_pressed("mouseright"):
			Input.warp_mouse(get_viewport().get_mouse_position() + Vector2(SPEED,0))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("contoller_connect"):
		if !CONTROLLER_CONNECTED:
			CONTROLLER_CONNECTED = true
		else:
			CONTROLLER_CONNECTED = false
