extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.CheapEffects = true
	else:
		Global.CheapEffects = false
	
func _ready() -> void:
	if Global.CheapEffects:
		button_pressed = true
	else:
		button_pressed = false
