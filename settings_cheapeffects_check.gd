extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	Global.CheapEffects = toggled_on
	
func _ready() -> void:
	button_pressed = Global.CheapEffects
