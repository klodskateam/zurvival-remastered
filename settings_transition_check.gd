extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.SmoothTransitions = true
	else:
		Global.SmoothTransitions = false
	
func _ready() -> void:
	if Global.SmoothTransitions:
		button_pressed = true
	else:
		button_pressed = false
