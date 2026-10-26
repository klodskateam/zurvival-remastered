extends CheckButton

# NOTE: чтобы запомнить
# 1. settings_x_check.gd
# 2. buttonsmenu.gd
# 3. global.gd

func _on_toggled(toggled_on: bool) -> void:
	Global.SHADOWS = !toggled_on
	
func _ready() -> void:
	button_pressed = !Global.SHADOWS
