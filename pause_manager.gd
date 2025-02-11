extends Node

@onready var pause_menu = $"../Pause"

var PAUSE = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		PAUSE = !PAUSE
	
func _process(delta: float) -> void:
	if PAUSE == true:
		get_tree().paused = true
		pause_menu.show()
	else:
		get_tree().paused = false
		pause_menu.hide()
