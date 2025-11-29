extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.WEAPONHINTS = false
	else:
		Global.WEAPONHINTS = true
	
func _ready() -> void:
	if !Global.WEAPONHINTS:
		button_pressed = true
	else:
		button_pressed = false
