extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	Global.SmoothTransitions = toggled_on
	
func _ready() -> void:
	button_pressed = Global.SmoothTransitions
