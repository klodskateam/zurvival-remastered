extends Node

@onready var pause_menu = $"../Pause"

var PAUSEMENU = false
var PAUSE = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		PAUSE = !PAUSE
		PAUSEMENU = !PAUSEMENU
	
func _process(delta: float) -> void:
	if PAUSE == true:
		get_tree().paused = true
	else:
		get_tree().paused = false

	if PAUSEMENU == true:
		pause_menu.show()
	else:
		pause_menu.hide()
