extends Button




func _on_button_down() -> void:
	Input.action_press("shoot")



func _on_button_up() -> void:
	Input.action_release("shoot")
